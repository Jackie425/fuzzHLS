total_num=1

.PHONY: all clean

all:
	bash fuzzHLS.sh $(total_num)

clean:
	rm -rf build/