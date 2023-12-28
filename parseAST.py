import re
import argparse

assign_line=[]
last_assign_line=0
last_assign_index=1
left_equal=[]
new_line=[]
mark_if_source_file=0
mark_if_result_function=0
result_return_line=0
# operator=['\'=\'','\'^=\'','\'+=\'', '\'|=\'']
parser = argparse.ArgumentParser(description="Parse AST")
parser.add_argument('sourcefile', help='Please input source file')
parser.add_argument('astfile', help='Please input AST file')
args = parser.parse_args()
with open(args.astfile, 'r') as file:
    ast_content = file.readlines()
with open(args.sourcefile, 'r') as file_source:
    source_content = file_source.readlines()


found_function_decl = False
found_next_declref =False


for line in ast_content:
    
    if args.sourcefile in line:
        mark_if_source_file = 1
    if "BinaryOperator" in line:
        if mark_if_source_file == 0:
            continue
        if "ForStmt" in last_ast_line:
            continue
        #print(line.strip())
        if(line.split()[-1] == '\'=\''):
            found_next_declref = True
            match = re.search(r'line:(\d+)', line)
            if match:
                line_number = match.group(1)
                assign_line.append(int(line_number))
            else:
                print("= no id")
    if "FunctionDecl" in line:
        if mark_if_source_file == 1:
            if "hls_top" in line:
                mark_if_result_function = 1
    if "ReturnStmt" in line:
        if mark_if_result_function == 1:
            match_2 = re.search(r'line:(\d+)', line)
            result_return_line = (int)(match_2.group(1))
    last_ast_line = line
print(assign_line)
for handle_line in assign_line:
    target_line = source_content[handle_line-1]
    if(handle_line != last_assign_line):
        last_assign_index = 1
        split_line = target_line.split('=', last_assign_index)
        left_of_equal = split_line[last_assign_index - 1].strip()
        left_equal.append(left_of_equal)
    else:
        last_assign_index = last_assign_index + 1
        split_line = target_line.split('=', last_assign_index)
        left_of_equal = split_line[last_assign_index - 1].strip()
        left_equal.append(left_of_equal)
    last_assign_line = handle_line


print(left_equal)

content_to_modify = source_content[result_return_line-1]
semicolon_index = content_to_modify.find(';')
if semicolon_index != -1:
    modified_content = content_to_modify[:semicolon_index] + "+ checksum_hercules" + content_to_modify[semicolon_index:]
    source_content[result_return_line-1] = modified_content
    print(modified_content)
else:
    print("no ;")

for i in range(len(assign_line)):
    assign_line[i]+=i
for i in range(len(assign_line)):
    new_line.append("       checksum_hercules += "+left_equal[i]+" ;\n")
for i in range(len(assign_line)):
    source_content.insert(assign_line[i], new_line[i])
# for insert_line in assign_line:
#     source_content.insert(insert_line, new_line)
#print(source_content)
source_content.insert(0, "int checksum_hercules = 0;")

with open(args.sourcefile, "w") as outfile:
    outfile.writelines(source_content)

