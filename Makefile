EXEC = tex2ml
SRC = src
BIN = bin

all: $(EXEC)

$(EXEC): $(SRC)/$(EXEC).yy.c $(SRC)/$(EXEC).tab.c
	mkdir -p bin/
	$(CC) $? -o $(BIN)/$(EXEC) -ll
	
# Bison
$(SRC)/$(EXEC).tab.c: $(SRC)/$(EXEC).y
	bison $< -o $@ -v

# Flex
$(SRC)/$(EXEC).yy.c: $(SRC)/$(EXEC).l
	flex -o $@ $<

clean:
	rm -rf $(SRC)/$(EXEC).yy.c $(SRC)/$(EXEC).tab.*