        Label        -mem-manager-initialize   
        DLabel       $heap-start-ptr           
        DataI        0                         
        DLabel       $heap-after-ptr           
        DataI        0                         
        DLabel       $heap-first-free          
        DataI        0                         
        DLabel       $mmgr-newblock-block      
        DataI        0                         
        DLabel       $mmgr-newblock-size       
        DataI        0                         
        PushD        $heap-memory              
        Duplicate                              
        PushD        $heap-start-ptr           
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Jump         $$main                    
        DLabel       $eat-location-zero        
        DataZ        8                         
        DLabel       $print-format-integer     
        DataC        37                        %% "%d"
        DataC        100                       
        DataC        0                         
        DLabel       $print-format-floating    
        DataC        37                        %% "%f"
        DataC        102                       
        DataC        0                         
        DLabel       $print-format-character   
        DataC        37                        %% "%c"
        DataC        99                        
        DataC        0                         
        DLabel       $print-format-boolean     
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-string      
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-newline     
        DataC        10                        %% "\n"
        DataC        0                         
        DLabel       $print-format-space       
        DataC        32                        %% " "
        DataC        0                         
        DLabel       $print-format-tab         
        DataC        9                         %% "\t"
        DataC        0                         
        DLabel       $boolean-true-string      
        DataC        116                       %% "true"
        DataC        114                       
        DataC        117                       
        DataC        101                       
        DataC        0                         
        DLabel       $boolean-false-string     
        DataC        102                       %% "false"
        DataC        97                        
        DataC        108                       
        DataC        115                       
        DataC        101                       
        DataC        0                         
        DLabel       $clear-n-return-address   
        DataI        0                         
        DLabel       $clear-num-bytes-temp     
        DataI        0                         
        Label        $$clear-n-bytes           
        PushD        $clear-n-return-address   
        Exchange                               
        StoreI                                 
        PushD        $clear-num-bytes-temp     
        Exchange                               
        StoreI                                 
        PushD        $clear-base-addr-temp     
        Exchange                               
        StoreI                                 
        PushI        0                         
        Label        $clear-n-bytes-loop       
        Duplicate                              
        PushD        $clear-num-bytes-temp     
        LoadI                                  
        Subtract                               
        JumpNeg      $clear-n-bytes-jump       
        Pop                                    
        PushD        $clear-n-return-address   
        LoadI                                  
        Return                                 
        Label        $clear-n-bytes-jump       
        Duplicate                              
        PushD        $clear-base-addr-temp     
        LoadI                                  
        Add                                    
        PushI        0                         
        StoreC                                 
        PushI        1                         
        Add                                    
        Jump         $clear-n-bytes-loop       
        DLabel       $bytecopy-n-return-address 
        DataI        0                         
        DLabel       $bytecopy-n-counter       
        DataI        0                         
        DLabel       $bytecopy-n-to-ptr        
        DataI        0                         
        DLabel       $bytecopy-n-from-ptr      
        DataI        0                         
        Label        $$bytecopy-n              
        PushD        $bytecopy-n-return-address 
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        Label        $$bytecopy-n-loop         
        PushD        $bytecopy-n-counter       
        LoadI                                  
        JumpPos      $$bytecopy-n-stay-in-loop 
        Jump         $$bytecopy-n-exit         
        Label        $$bytecopy-n-stay-in-loop 
        PushI        -1                        
        PushD        $bytecopy-n-counter       
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        LoadC                                  
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        Jump         $$bytecopy-n-loop         
        Label        $$bytecopy-n-exit         
        PushD        $bytecopy-n-return-address 
        LoadI                                  
        Return                                 
        Label        $$bytecopy-n-backwards    
        PushD        $bytecopy-n-return-address 
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-counter       
        LoadI                                  
        PushI        1                         
        Subtract                               
        Duplicate                              
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        Label        $$bytecopy-n-backwards-loop 
        PushD        $bytecopy-n-counter       
        LoadI                                  
        JumpPos      $$bytecopy-n-backwards-stay-in-loop 
        Jump         $$bytecopy-n-backwards-exit 
        Label        $$bytecopy-n-backwards-stay-in-loop 
        PushI        -1                        
        PushD        $bytecopy-n-counter       
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        LoadC                                  
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushI        -1                        
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        Jump         $$bytecopy-n-backwards-loop 
        Label        $$bytecopy-n-backwards-exit 
        PushD        $bytecopy-n-return-address 
        LoadI                                  
        Return                                 
        Label        $$bytecopy-n-reversed     
        PushD        $bytecopy-n-return-address 
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-counter       
        LoadI                                  
        PushI        1                         
        Subtract                               
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        Label        $$bytecopy-n-reversed-loop 
        PushD        $bytecopy-n-counter       
        LoadI                                  
        JumpPos      $$bytecopy-n-reversed-stay-in-loop 
        Jump         $$bytecopy-n-reversed-exit 
        Label        $$bytecopy-n-reversed-stay-in-loop 
        PushI        -1                        
        PushD        $bytecopy-n-counter       
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-counter       
        Exchange                               
        StoreI                                 
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        LoadC                                  
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Exchange                               
        StoreC                                 
        PushI        -1                        
        PushD        $bytecopy-n-from-ptr      
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-from-ptr      
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $bytecopy-n-to-ptr        
        LoadI                                  
        Add                                    
        PushD        $bytecopy-n-to-ptr        
        Exchange                               
        StoreI                                 
        Jump         $$bytecopy-n-reversed-loop 
        Label        $$bytecopy-n-reversed-exit 
        PushD        $bytecopy-n-return-address 
        LoadI                                  
        Return                                 
        DLabel       $arraycopy-size-temp      
        DataI        0                         
        DLabel       $record-create-temp       
        DataI        0                         
        DLabel       $array-datasize-temp      
        DataI        0                         
        DLabel       $array-concat-length      
        DataI        0                         
        DLabel       $array-indexing-index     
        DataI        0                         
        DLabel       $array-indexing-index2    
        DataI        0                         
        DLabel       $array-loop-index         
        DataI        0                         
        DLabel       $errors-negative-number-given-for-array-length 
        DataC        110                       %% "negative number given for array length"
        DataC        101                       
        DataC        103                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        32                        
        DataC        110                       
        DataC        117                       
        DataC        109                       
        DataC        98                        
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        103                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        110                       
        DataC        32                        
        DataC        102                       
        DataC        111                       
        DataC        114                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        0                         
        Label        $$negative-length-array   
        PushD        $errors-negative-number-given-for-array-length 
        Jump         $$general-runtime-error   
        DLabel       $errors-array-index-out-of-bounds 
        DataC        97                        %% "array index out of bounds"
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        111                       
        DataC        117                       
        DataC        116                       
        DataC        32                        
        DataC        111                       
        DataC        102                       
        DataC        32                        
        DataC        98                        
        DataC        111                       
        DataC        117                       
        DataC        110                       
        DataC        100                       
        DataC        115                       
        DataC        0                         
        Label        $$a-index-out-of-bounds   
        PushD        $errors-array-index-out-of-bounds 
        Jump         $$general-runtime-error   
        DLabel       $errors-integer-divide-by-zero 
        DataC        105                       %% "integer divide by zero"
        DataC        110                       
        DataC        116                       
        DataC        101                       
        DataC        103                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$i-divide-by-zero        
        PushD        $errors-integer-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $errors-floating-divide-by-zero 
        DataC        102                       %% "floating divide by zero"
        DataC        108                       
        DataC        111                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$f-divide-by-zero        
        PushD        $errors-floating-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $errors-attempt-to-index-using-null-array 
        DataC        97                        %% "attempt to index using null array"
        DataC        116                       
        DataC        116                       
        DataC        101                       
        DataC        109                       
        DataC        112                       
        DataC        116                       
        DataC        32                        
        DataC        116                       
        DataC        111                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        117                       
        DataC        115                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        110                       
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        0                         
        Label        $$a-null-base-array       
        PushD        $errors-attempt-to-index-using-null-array 
        Jump         $$general-runtime-error   
        DLabel       $errors-attempt-to-use-released-array 
        DataC        97                        %% "attempt to use released array"
        DataC        116                       
        DataC        116                       
        DataC        101                       
        DataC        109                       
        DataC        112                       
        DataC        116                       
        DataC        32                        
        DataC        116                       
        DataC        111                       
        DataC        32                        
        DataC        117                       
        DataC        115                       
        DataC        101                       
        DataC        32                        
        DataC        114                       
        DataC        101                       
        DataC        108                       
        DataC        101                       
        DataC        97                        
        DataC        115                       
        DataC        101                       
        DataC        100                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        0                         
        Label        $$a-dangle-array          
        PushD        $errors-attempt-to-use-released-array 
        Jump         $$general-runtime-error   
        DLabel       $errors-negative-length-given-for-array 
        DataC        110                       %% "negative length given for array"
        DataC        101                       
        DataC        103                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        32                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        32                        
        DataC        103                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        110                       
        DataC        32                        
        DataC        102                       
        DataC        111                       
        DataC        114                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        0                         
        Label        $$a-negative-length       
        PushD        $errors-negative-length-given-for-array 
        Jump         $$general-runtime-error   
        DLabel       $errors-general-message   
        DataC        82                        %% "Runtime error: %s\n"
        DataC        117                       
        DataC        110                       
        DataC        116                       
        DataC        105                       
        DataC        109                       
        DataC        101                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        58                        
        DataC        32                        
        DataC        37                        
        DataC        115                       
        DataC        10                        
        DataC        0                         
        Label        $$general-runtime-error   
        PushD        $errors-general-message   
        Printf                                 
        Halt                                   
        DLabel       $usable-memory-start      
        DLabel       $array-start-string       
        DataC        91                        %% "["
        DataC        0                         
        DLabel       $array-middle-string      
        DataC        44                        %% ", "
        DataC        32                        
        DataC        0                         
        DLabel       $array-end-string         
        DataC        93                        %% "]"
        DataC        0                         
        DLabel       $print-null-string        
        DataC        110                       %% "null"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        0                         
        DLabel       $array-printing-index     
        DataI        0                         
        DLabel       $global-memory-block      
        DataZ        4                         
        Label        $$main                    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        Label        -blankArray-1-start       
        PushI        3                         
        Nop                                    
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        2                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        4                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -blankArray-1-end         
        StoreI                                 
        Label        -arrayIndexing-2-args-start 
        Label        -arrayIndexing-2-arg1     
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-2-arg2     
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-2-start    
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-2-end      
        Label        -blankArray-3-start       
        PushI        3                         
        Nop                                    
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        2                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        4                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -blankArray-3-end         
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-4-args-start 
        Label        -arrayIndexing-4-arg1     
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-4-arg2     
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-4-start    
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-4-end      
        Label        -blankArray-5-start       
        PushI        3                         
        Nop                                    
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        2                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        4                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -blankArray-5-end         
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-6-args-start 
        Label        -arrayIndexing-6-arg1     
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-6-arg2     
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-6-start    
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-6-end      
        Label        -blankArray-7-start       
        PushI        3                         
        Nop                                    
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        4                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        2                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        4                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -blankArray-7-end         
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-9-args-start 
        Label        -arrayIndexing-9-arg1     
        Label        -arrayIndexing-8-args-start 
        Label        -arrayIndexing-8-arg1     
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-8-arg2     
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-8-start    
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-8-end      
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-9-arg2     
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-9-start    
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-9-end      
        Label        -populatedArray-10-start  
        PushI        3                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-10-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        97                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        98                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        99                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-10-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-12-args-start 
        Label        -arrayIndexing-12-arg1    
        Label        -arrayIndexing-11-args-start 
        Label        -arrayIndexing-11-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-11-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-11-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-11-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-12-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-12-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-12-end     
        Label        -populatedArray-13-start  
        PushI        3                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-13-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        100                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        101                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        102                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-13-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-15-args-start 
        Label        -arrayIndexing-15-arg1    
        Label        -arrayIndexing-14-args-start 
        Label        -arrayIndexing-14-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-14-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-14-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-14-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-15-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-15-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-15-end     
        Label        -populatedArray-16-start  
        PushI        5                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-16-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        103                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        104                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        105                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        106                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        19                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        107                       
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        20                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-16-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-18-args-start 
        Label        -arrayIndexing-18-arg1    
        Label        -arrayIndexing-17-args-start 
        Label        -arrayIndexing-17-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-17-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-17-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-17-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-18-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-18-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-18-end     
        Label        -populatedArray-19-start  
        PushI        4                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-19-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        65                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        66                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        67                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        68                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        19                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-19-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-21-args-start 
        Label        -arrayIndexing-21-arg1    
        Label        -arrayIndexing-20-args-start 
        Label        -arrayIndexing-20-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-20-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-20-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-20-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-21-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-21-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-21-end     
        Label        -arrayIndexing-23-args-start 
        Label        -arrayIndexing-23-arg1    
        Label        -arrayIndexing-22-args-start 
        Label        -arrayIndexing-22-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-22-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-22-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-22-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-23-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-23-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-23-end     
        LoadI                                  
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-25-args-start 
        Label        -arrayIndexing-25-arg1    
        Label        -arrayIndexing-24-args-start 
        Label        -arrayIndexing-24-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-24-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-24-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-24-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-25-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-25-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-25-end     
        Label        -populatedArray-26-start  
        PushI        3                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-26-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        73                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        74                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        75                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-26-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-28-args-start 
        Label        -arrayIndexing-28-arg1    
        Label        -arrayIndexing-27-args-start 
        Label        -arrayIndexing-27-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-27-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-27-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-27-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-28-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-28-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-28-end     
        Label        -populatedArray-29-start  
        PushI        1                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-29-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        61                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-29-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-31-args-start 
        Label        -arrayIndexing-31-arg1    
        Label        -arrayIndexing-30-args-start 
        Label        -arrayIndexing-30-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-30-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-30-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-30-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-31-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-31-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-31-end     
        Label        -populatedArray-32-start  
        PushI        4                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-32-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        45                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        43                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        42                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        47                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        19                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-32-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-34-args-start 
        Label        -arrayIndexing-34-arg1    
        Label        -arrayIndexing-33-args-start 
        Label        -arrayIndexing-33-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-33-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-33-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-33-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-34-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-34-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-34-end     
        Label        -populatedArray-35-start  
        PushI        4                         
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        1                         
        Multiply                               
        Duplicate                              
        PushD        $array-datasize-temp      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        0                         
        Add                                    
        PushI        5                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        4                         
        Add                                    
        PushI        0                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $array-datasize-temp      
        LoadI                                  
        Call         $$clear-n-bytes           
        PushD        $record-create-temp       
        LoadI                                  
        PushI        8                         
        Add                                    
        PushI        1                         
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -populatedArray-35-startChildren 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        64                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        35                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        36                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        37                        
        Nop                                    
        Exchange                               
        PushD        $record-create-temp       
        Exchange                               
        StoreI                                 
        PushD        $record-create-temp       
        LoadI                                  
        PushI        19                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-create-temp       
        LoadI                                  
        Label        -populatedArray-35-end    
        Nop                                    
        StoreI                                 
        Label        -arrayIndexing-38-args-start 
        Label        -arrayIndexing-38-arg1    
        Label        -arrayIndexing-37-args-start 
        Label        -arrayIndexing-37-arg1    
        Label        -arrayIndexing-36-args-start 
        Label        -arrayIndexing-36-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-36-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-36-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-36-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-37-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-37-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-37-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-38-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-38-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-38-end     
        PushI        69                        
        Nop                                    
        StoreC                                 
        Label        -arrayIndexing-41-args-start 
        Label        -arrayIndexing-41-arg1    
        Label        -arrayIndexing-40-args-start 
        Label        -arrayIndexing-40-arg1    
        Label        -arrayIndexing-39-args-start 
        Label        -arrayIndexing-39-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-39-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-39-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-39-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-40-arg2    
        PushI        0                         
        Nop                                    
        Label        -arrayIndexing-40-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-40-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-41-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-41-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-41-end     
        PushI        70                        
        Nop                                    
        StoreC                                 
        Label        -arrayIndexing-43-args-start 
        Label        -arrayIndexing-43-arg1    
        Label        -arrayIndexing-42-args-start 
        Label        -arrayIndexing-42-arg1    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-42-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-42-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-42-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-43-arg2    
        PushI        1                         
        Nop                                    
        Label        -arrayIndexing-43-start   
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Duplicate                              
        Pop                                    
        PushI        0                         
        Exchange                               
        PushI        12                        
        Add                                    
        LoadI                                  
        Add                                    
        PushI        1                         
        Subtract                               
        PushD        $array-indexing-index     
        LoadI                                  
        Subtract                               
        JumpNeg      $$a-index-out-of-bounds   
        Duplicate                              
        Pop                                    
        PushI        0                         
        PushD        $array-indexing-index     
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $array-indexing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-indexing-index     
        LoadI                                  
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        Label        -arrayIndexing-43-end     
        LoadI                                  
        Label        -arrayPrint-44-start      
        Duplicate                              
        JumpTrue     -arrayPrint-44-nonNull    
        Pop                                    
        PushD        $print-null-string        
        Printf                                 
        Jump         -arrayPrint-44-end        
        Label        -arrayPrint-44-nonNull    
        PushD        $array-start-string       
        PushD        $print-format-string      
        Printf                                 
        PushI        0                         
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        JumpFalse    -arrayPrint-44-loopExit   
        Label        -arrayPrint-44-loop       
        Duplicate                              
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Multiply                               
        Add                                    
        PushI        16                        
        Add                                    
        LoadC                                  
        PushD        $array-printing-index     
        LoadI                                  
        Exchange                               
        PushD        $print-format-character   
        Printf                                 
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $array-printing-index     
        LoadI                                  
        Add                                    
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Subtract                               
        JumpPos      -arrayPrint-44-loopContinue 
        Jump         -arrayPrint-44-loopExit   
        Label        -arrayPrint-44-loopContinue 
        PushD        $array-middle-string      
        PushD        $print-format-string      
        Printf                                 
        Jump         -arrayPrint-44-loop       
        Label        -arrayPrint-44-loopExit   
        Pop                                    
        PushD        $array-end-string         
        PushD        $print-format-string      
        Printf                                 
        Label        -arrayPrint-44-end        
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AAA
        LoadI                                  
        Label        -arrayPrint-45-start      
        Duplicate                              
        JumpTrue     -arrayPrint-45-nonNull    
        Pop                                    
        PushD        $print-null-string        
        Printf                                 
        Jump         -arrayPrint-45-end        
        Label        -arrayPrint-45-nonNull    
        PushD        $array-start-string       
        PushD        $print-format-string      
        Printf                                 
        PushI        0                         
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        JumpFalse    -arrayPrint-45-loopExit   
        Label        -arrayPrint-45-loop       
        Duplicate                              
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Multiply                               
        Add                                    
        PushI        16                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Exchange                               
        Label        -arrayPrint-46-start      
        Duplicate                              
        JumpTrue     -arrayPrint-46-nonNull    
        Pop                                    
        PushD        $print-null-string        
        Printf                                 
        Jump         -arrayPrint-46-end        
        Label        -arrayPrint-46-nonNull    
        PushD        $array-start-string       
        PushD        $print-format-string      
        Printf                                 
        PushI        0                         
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        JumpFalse    -arrayPrint-46-loopExit   
        Label        -arrayPrint-46-loop       
        Duplicate                              
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Multiply                               
        Add                                    
        PushI        16                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Exchange                               
        Label        -arrayPrint-47-start      
        Duplicate                              
        JumpTrue     -arrayPrint-47-nonNull    
        Pop                                    
        PushD        $print-null-string        
        Printf                                 
        Jump         -arrayPrint-47-end        
        Label        -arrayPrint-47-nonNull    
        PushD        $array-start-string       
        PushD        $print-format-string      
        Printf                                 
        PushI        0                         
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        JumpFalse    -arrayPrint-47-loopExit   
        Label        -arrayPrint-47-loop       
        Duplicate                              
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Multiply                               
        Add                                    
        PushI        16                        
        Add                                    
        LoadC                                  
        PushD        $array-printing-index     
        LoadI                                  
        Exchange                               
        PushD        $print-format-character   
        Printf                                 
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $array-printing-index     
        LoadI                                  
        Add                                    
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Subtract                               
        JumpPos      -arrayPrint-47-loopContinue 
        Jump         -arrayPrint-47-loopExit   
        Label        -arrayPrint-47-loopContinue 
        PushD        $array-middle-string      
        PushD        $print-format-string      
        Printf                                 
        Jump         -arrayPrint-47-loop       
        Label        -arrayPrint-47-loopExit   
        Pop                                    
        PushD        $array-end-string         
        PushD        $print-format-string      
        Printf                                 
        Label        -arrayPrint-47-end        
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $array-printing-index     
        LoadI                                  
        Add                                    
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Subtract                               
        JumpPos      -arrayPrint-46-loopContinue 
        Jump         -arrayPrint-46-loopExit   
        Label        -arrayPrint-46-loopContinue 
        PushD        $array-middle-string      
        PushD        $print-format-string      
        Printf                                 
        Jump         -arrayPrint-46-loop       
        Label        -arrayPrint-46-loopExit   
        Pop                                    
        PushD        $array-end-string         
        PushD        $print-format-string      
        Printf                                 
        Label        -arrayPrint-46-end        
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $array-printing-index     
        LoadI                                  
        Add                                    
        PushD        $array-printing-index     
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    $$a-null-base-array       
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        5                         
        Subtract                               
        BNegate                                
        JumpFalse    $$a-dangle-array          
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        $array-printing-index     
        LoadI                                  
        Subtract                               
        JumpPos      -arrayPrint-45-loopContinue 
        Jump         -arrayPrint-45-loopExit   
        Label        -arrayPrint-45-loopContinue 
        PushD        $array-middle-string      
        PushD        $print-format-string      
        Printf                                 
        Jump         -arrayPrint-45-loop       
        Label        -arrayPrint-45-loopExit   
        Pop                                    
        PushD        $array-end-string         
        PushD        $print-format-string      
        Printf                                 
        Label        -arrayPrint-45-end        
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        Halt                                   
        Label        -mem-manager-make-tags    
        DLabel       $mmgr-tags-size           
        DataI        0                         
        DLabel       $mmgr-tags-start          
        DataI        0                         
        DLabel       $mmgr-tags-available      
        DataI        0                         
        DLabel       $mmgr-tags-nextptr        
        DataI        0                         
        DLabel       $mmgr-tags-prevptr        
        DataI        0                         
        DLabel       $mmgr-tags-return         
        DataI        0                         
        PushD        $mmgr-tags-return         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-size           
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-start          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-available      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-nextptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-nextptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-return         
        LoadI                                  
        Return                                 
        Label        -mem-manager-one-tag      
        DLabel       $mmgr-onetag-return       
        DataI        0                         
        DLabel       $mmgr-onetag-location     
        DataI        0                         
        DLabel       $mmgr-onetag-available    
        DataI        0                         
        DLabel       $mmgr-onetag-size         
        DataI        0                         
        DLabel       $mmgr-onetag-pointer      
        DataI        0                         
        PushD        $mmgr-onetag-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-onetag-return       
        LoadI                                  
        Return                                 
        Label        -mem-manager-allocate     
        DLabel       $mmgr-alloc-return        
        DataI        0                         
        DLabel       $mmgr-alloc-size          
        DataI        0                         
        DLabel       $mmgr-alloc-current-block 
        DataI        0                         
        DLabel       $mmgr-alloc-remainder-block 
        DataI        0                         
        DLabel       $mmgr-alloc-remainder-size 
        DataI        0                         
        PushD        $mmgr-alloc-return        
        Exchange                               
        StoreI                                 
        PushI        18                        
        Add                                    
        PushD        $mmgr-alloc-size          
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-process-current 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        JumpFalse    -mmgr-alloc-no-block-works 
        Label        -mmgr-alloc-test-block    
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        1                         
        Add                                    
        JumpPos      -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Jump         -mmgr-alloc-process-current 
        Label        -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Call         -mem-manager-remove-block 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        26                        
        Subtract                               
        JumpNeg      -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Add                                    
        PushD        $mmgr-alloc-remainder-block 
        Exchange                               
        StoreI                                 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $mmgr-alloc-remainder-size 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushI        0                         
        PushI        0                         
        PushI        1                         
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushD        $mmgr-alloc-remainder-size 
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        Call         -mem-manager-deallocate   
        Jump         -mmgr-alloc-return-userblock 
        Label        -mmgr-alloc-no-block-works 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-newblock-size       
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        LoadI                                  
        PushD        $mmgr-newblock-block      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-newblock-size       
        LoadI                                  
        PushD        $heap-after-ptr           
        LoadI                                  
        Add                                    
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-newblock-size       
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        PushD        $mmgr-alloc-return        
        LoadI                                  
        Return                                 
        Label        -mem-manager-deallocate   
        DLabel       $mmgr-dealloc-return      
        DataI        0                         
        DLabel       $mmgr-dealloc-block       
        DataI        0                         
        PushD        $mmgr-dealloc-return      
        Exchange                               
        StoreI                                 
        PushI        9                         
        Subtract                               
        PushD        $mmgr-dealloc-block       
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        JumpFalse    -mmgr-bypass-firstFree    
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-bypass-firstFree    
        PushI        0                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-dealloc-return      
        LoadI                                  
        Return                                 
        Label        -mem-manager-remove-block 
        DLabel       $mmgr-remove-return       
        DataI        0                         
        DLabel       $mmgr-remove-block        
        DataI        0                         
        DLabel       $mmgr-remove-prev         
        DataI        0                         
        DLabel       $mmgr-remove-next         
        DataI        0                         
        PushD        $mmgr-remove-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-prev         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-next         
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-prev 
        PushD        $mmgr-remove-prev         
        LoadI                                  
        JumpFalse    -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $mmgr-remove-prev         
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Jump         -mmgr-remove-process-next 
        Label        -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-next 
        PushD        $mmgr-remove-next         
        LoadI                                  
        JumpFalse    -mmgr-remove-done         
        PushD        $mmgr-remove-prev         
        LoadI                                  
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-done         
        PushD        $mmgr-remove-return       
        LoadI                                  
        Return                                 
        DLabel       $heap-memory              
