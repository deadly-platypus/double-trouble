#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <elf.h>
#include <string.h>

char *mmap_app;

void execute_function(const char *function, Elf64_Shdr *text_header) {
    printf("Attempting to find function %s\n", function);    
    Elf64_Off offset = text_header->sh_offset;
    Elf64_Xword size = text_header->sh_size;

    int (*func)(int, int) = (void*)(mmap_app + offset);
    int test = func(1, 3);
    printf("function returned: %d\n", test);
}

int main(int argc, char** argv) {
    int i;
    int obj = open("test.o", O_RDWR);
    if(!obj) {
        fprintf(stderr, "Error opening test.o\n");
        exit(1);
    }
    struct stat filestat;
    fstat(obj, &filestat);

    mmap_app = (char*)mmap(NULL, filestat.st_size, PROT_WRITE | PROT_READ | PROT_EXEC, MAP_SHARED, obj, 0);
    if(!mmap_app) {
        fprintf(stderr, "Error memory mapping object file\n");
        exit(1);
    }
    printf("Memory mapping successful\n");
    Elf64_Ehdr *header = (Elf64_Ehdr*)mmap_app;
    Elf64_Shdr *sect_header = (Elf64_Shdr*)(mmap_app + header->e_shoff);
    int num_sect_header = header->e_shnum;
    Elf64_Shdr *strtab = &sect_header[header->e_shstrndx];
    const char *const strtab_data = mmap_app + strtab->sh_offset;
    for(i = 0; i < num_sect_header; i++) {
        const char *const sect_name = strtab_data + sect_header[i].sh_name;
        if(strcmp(sect_name, ".text") == 0) {
           execute_function("test_printf", &sect_header[i]); 
           break;
        }
    }
    
    munmap(mmap_app, filestat.st_size);
    close(obj);
    return 0;
}
