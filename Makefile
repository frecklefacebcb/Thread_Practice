RM := rm -rf
MK := mkdir
CP := cp -v

CFLAGS := -c -Wall
LDFLAGS := 

BUILD_DIR := build
OUTPUT_BIN := Thread_Practice

INCLUDE_PATH := 

SOURCE_FILES := Thread_Practice.c

SOURCE_OBJECTS := $(addprefix $(BUILD_DIR)/, $(SOURCE_FILES:.c=.o) )

all: release

debug: CFLAGS += -DDEBUG -g -O0
debug: clean $(BUILD_DIR)/$(OUTPUT_BIN)

release: CFLAGS += -DNDEBUG -O3
release: clean $(BUILD_DIR)/$(OUTPUT_BIN)

.PHONY: install
install: $(BUILD_DIR)/$(OUTPUT_BIN)
	sudo $(CP) $(BUILD_DIR)/$(OUTPUT_BIN) $(RELEASE_DIR)/$(OUTPUT_BIN)

$(BUILD_DIR):
	$(MK) $@

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE_PATH) -M $< -MF $(@:.o=.d) -MT $@
	$(CC) $(CFLAGS) $(INCLUDE_PATH) -c -o $@ $<

$(BUILD_DIR)/$(OUTPUT_BIN): $(BUILD_DIR) $(SOURCE_OBJECTS)
	$(CC) $(LDFLAGS) $(SOURCE_OBJECTS) -o $@

.PHONY: clean
clean:
	$(RM) $(BUILD_DIR)
