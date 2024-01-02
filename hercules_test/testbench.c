#include <stdio.h>
#include <string.h>
#include <stdint.h>

int main (void) {
  int res;
  char *check_file;
  char *cosim_result_file;
  check_file = "/home/jackie/RISC-V_Research/fuzzHLS/hercules_test/check.data";
  cosim_result_file = "/home/jackie/RISC-V_Research/fuzzHLS/hercules_test/cosim_result.data";
  FILE *file = fopen(check_file, "r");
  if(file == NULL) {
	printf("Failed to open file\n");
  	return 1;
  }
  char ref[100];
  char ch;
  int i = 0;

  while ((ch = fgetc(file)) != EOF && i < 99) {
	  ref[i] = ch;
	  i++;
  }
  ref[i] = '\0';

  fclose(file);

  char dut[100];

  res = hls_top();

  sprintf(dut, "%X\n", res);
  FILE *file1 = fopen(cosim_result_file, "wr");
  if(file == NULL) {
	  printf("Failed to open file\n");
  	return 1;
  }
  if (strcmp(ref, dut) == 0) {
    fprintf(file, "Cosim SUCCESS");
	  return 0;
  } else {
    fprintf(file, "Cosim FAIL");
    printf("ref: %s\n",ref);
    printf("dut: %s\n",dut);
	 return 1;
  }
  return 1;
}
