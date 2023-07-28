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
        DataZ        24                        
        Label        $$main                    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% size
        PushI        5000                      
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% printEvery
        PushI        50                        
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        Label        -blankArray-1-start       
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% size
        LoadI                                  
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
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushI        0                         
        StoreI                                 
        Label        -while-2-continueTarget   
        Label        -while-2-condition        
        Label        -compare-3-args-start     
        Label        -compare-3-arg1           
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -compare-3-arg2           
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% size
        LoadI                                  
        Nop                                    
        Label        -compare-3-start          
        Subtract                               
        JumpNeg      -compare-3-true           
        Jump         -compare-3-false          
        Label        -compare-3-true           
        PushI        1                         
        Jump         -compare-3-join           
        Label        -compare-3-false          
        PushI        0                         
        Jump         -compare-3-join           
        Label        -compare-3-join           
        JumpFalse    -while-2-end              
        Label        -while-2-body             
        Label        -arrayIndexing-4-args-start 
        Label        -arrayIndexing-4-arg1     
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-4-arg2     
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        7                         
        Nop                                    
        Duplicate                              
        JumpNeg      $$a-negative-length       
        Duplicate                              
        PushI        8                         
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
        PushI        8                         
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
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        PushI        1                         
        Nop                                    
        Add                                    
        Nop                                    
        StoreI                                 
        Jump         -while-2-condition        
        Label        -while-2-breakTarget      
        Label        -while-2-end              
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushI        0                         
        Nop                                    
        StoreI                                 
        Label        -while-6-continueTarget   
        Label        -while-6-condition        
        Label        -compare-7-args-start     
        Label        -compare-7-arg1           
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -compare-7-arg2           
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% size
        LoadI                                  
        Nop                                    
        Label        -compare-7-start          
        Subtract                               
        JumpNeg      -compare-7-true           
        Jump         -compare-7-false          
        Label        -compare-7-true           
        PushI        1                         
        Jump         -compare-7-join           
        Label        -compare-7-false          
        PushI        0                         
        Jump         -compare-7-join           
        Label        -compare-7-join           
        JumpFalse    -while-6-end              
        Label        -while-6-body             
        Label        -arrayIndexing-9-args-start 
        Label        -arrayIndexing-9-arg1     
        Label        -arrayIndexing-8-args-start 
        Label        -arrayIndexing-8-arg1     
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-8-arg2     
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushF        0.010000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-11-args-start 
        Label        -arrayIndexing-11-arg1    
        Label        -arrayIndexing-10-args-start 
        Label        -arrayIndexing-10-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-10-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-10-start   
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
        Label        -arrayIndexing-10-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-11-arg2    
        PushI        1                         
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
        PushF        0.200000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-13-args-start 
        Label        -arrayIndexing-13-arg1    
        Label        -arrayIndexing-12-args-start 
        Label        -arrayIndexing-12-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-12-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-13-arg2    
        PushI        2                         
        Nop                                    
        Label        -arrayIndexing-13-start   
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
        Label        -arrayIndexing-13-end     
        PushF        3.000000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-15-args-start 
        Label        -arrayIndexing-15-arg1    
        Label        -arrayIndexing-14-args-start 
        Label        -arrayIndexing-14-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-14-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        3                         
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
        PushF        40.000000                 
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-17-args-start 
        Label        -arrayIndexing-17-arg1    
        Label        -arrayIndexing-16-args-start 
        Label        -arrayIndexing-16-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-16-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-16-start   
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
        Label        -arrayIndexing-16-end     
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-17-arg2    
        PushI        4                         
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
        PushF        500.000000                
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-19-args-start 
        Label        -arrayIndexing-19-arg1    
        Label        -arrayIndexing-18-args-start 
        Label        -arrayIndexing-18-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-18-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-19-arg2    
        PushI        5                         
        Nop                                    
        Label        -arrayIndexing-19-start   
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
        Label        -arrayIndexing-19-end     
        PushF        6000.000000               
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        Label        -arrayIndexing-21-args-start 
        Label        -arrayIndexing-21-arg1    
        Label        -arrayIndexing-20-args-start 
        Label        -arrayIndexing-20-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-20-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        6                         
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
        PushF        70000.000000              
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        StoreF                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        PushI        1                         
        Nop                                    
        Add                                    
        Nop                                    
        StoreI                                 
        Jump         -while-6-condition        
        Label        -while-6-breakTarget      
        Label        -while-6-end              
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushI        0                         
        Nop                                    
        StoreI                                 
        Label        -while-22-continueTarget  
        Label        -while-22-condition       
        Label        -compare-23-args-start    
        Label        -compare-23-arg1          
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -compare-23-arg2          
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% size
        LoadI                                  
        Nop                                    
        Label        -compare-23-start         
        Subtract                               
        JumpNeg      -compare-23-true          
        Jump         -compare-23-false         
        Label        -compare-23-true          
        PushI        1                         
        Jump         -compare-23-join          
        Label        -compare-23-false         
        PushI        0                         
        Jump         -compare-23-join          
        Label        -compare-23-join          
        JumpFalse    -while-22-end             
        Label        -while-22-body            
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% elem1
        Label        -compare-26-args-start    
        Label        -compare-26-arg1          
        PushF        0.010000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-26-arg2          
        Label        -arrayIndexing-25-args-start 
        Label        -arrayIndexing-25-arg1    
        Label        -arrayIndexing-24-args-start 
        Label        -arrayIndexing-24-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-24-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        0                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-26-start         
        FSubtract                              
        JumpFZero    -compare-26-true          
        Jump         -compare-26-false         
        Label        -compare-26-true          
        PushI        1                         
        Jump         -compare-26-join          
        Label        -compare-26-false         
        PushI        0                         
        Jump         -compare-26-join          
        Label        -compare-26-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        17                        
        Add                                    %% elem2
        Label        -compare-29-args-start    
        Label        -compare-29-arg1          
        PushF        0.200000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-29-arg2          
        Label        -arrayIndexing-28-args-start 
        Label        -arrayIndexing-28-arg1    
        Label        -arrayIndexing-27-args-start 
        Label        -arrayIndexing-27-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-27-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        1                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-29-start         
        FSubtract                              
        JumpFZero    -compare-29-true          
        Jump         -compare-29-false         
        Label        -compare-29-true          
        PushI        1                         
        Jump         -compare-29-join          
        Label        -compare-29-false         
        PushI        0                         
        Jump         -compare-29-join          
        Label        -compare-29-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        18                        
        Add                                    %% elem3
        Label        -compare-32-args-start    
        Label        -compare-32-arg1          
        PushF        3.000000                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-32-arg2          
        Label        -arrayIndexing-31-args-start 
        Label        -arrayIndexing-31-arg1    
        Label        -arrayIndexing-30-args-start 
        Label        -arrayIndexing-30-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-30-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        2                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-32-start         
        FSubtract                              
        JumpFZero    -compare-32-true          
        Jump         -compare-32-false         
        Label        -compare-32-true          
        PushI        1                         
        Jump         -compare-32-join          
        Label        -compare-32-false         
        PushI        0                         
        Jump         -compare-32-join          
        Label        -compare-32-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        19                        
        Add                                    %% elem4
        Label        -compare-35-args-start    
        Label        -compare-35-arg1          
        PushF        40.000000                 
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-35-arg2          
        Label        -arrayIndexing-34-args-start 
        Label        -arrayIndexing-34-arg1    
        Label        -arrayIndexing-33-args-start 
        Label        -arrayIndexing-33-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-33-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        3                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-35-start         
        FSubtract                              
        JumpFZero    -compare-35-true          
        Jump         -compare-35-false         
        Label        -compare-35-true          
        PushI        1                         
        Jump         -compare-35-join          
        Label        -compare-35-false         
        PushI        0                         
        Jump         -compare-35-join          
        Label        -compare-35-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% elem5
        Label        -compare-38-args-start    
        Label        -compare-38-arg1          
        PushF        500.000000                
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-38-arg2          
        Label        -arrayIndexing-37-args-start 
        Label        -arrayIndexing-37-arg1    
        Label        -arrayIndexing-36-args-start 
        Label        -arrayIndexing-36-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-36-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        4                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-38-start         
        FSubtract                              
        JumpFZero    -compare-38-true          
        Jump         -compare-38-false         
        Label        -compare-38-true          
        PushI        1                         
        Jump         -compare-38-join          
        Label        -compare-38-false         
        PushI        0                         
        Jump         -compare-38-join          
        Label        -compare-38-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        21                        
        Add                                    %% elem6
        Label        -compare-41-args-start    
        Label        -compare-41-arg1          
        PushF        6000.000000               
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-41-arg2          
        Label        -arrayIndexing-40-args-start 
        Label        -arrayIndexing-40-arg1    
        Label        -arrayIndexing-39-args-start 
        Label        -arrayIndexing-39-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-39-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        5                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-41-start         
        FSubtract                              
        JumpFZero    -compare-41-true          
        Jump         -compare-41-false         
        Label        -compare-41-true          
        PushI        1                         
        Jump         -compare-41-join          
        Label        -compare-41-false         
        PushI        0                         
        Jump         -compare-41-join          
        Label        -compare-41-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        22                        
        Add                                    %% elem7
        Label        -compare-44-args-start    
        Label        -compare-44-arg1          
        PushF        70000.000000              
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Nop                                    
        ConvertF                               
        Nop                                    
        FAdd                                   
        Nop                                    
        Label        -compare-44-arg2          
        Label        -arrayIndexing-43-args-start 
        Label        -arrayIndexing-43-arg1    
        Label        -arrayIndexing-42-args-start 
        Label        -arrayIndexing-42-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% arrays
        LoadI                                  
        Nop                                    
        Label        -arrayIndexing-42-arg2    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
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
        PushI        6                         
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
        LoadF                                  
        Nop                                    
        Label        -compare-44-start         
        FSubtract                              
        JumpFZero    -compare-44-true          
        Jump         -compare-44-false         
        Label        -compare-44-true          
        PushI        1                         
        Jump         -compare-44-join          
        Label        -compare-44-false         
        PushI        0                         
        Jump         -compare-44-join          
        Label        -compare-44-join          
        StoreC                                 
        PushD        $global-memory-block      
        PushI        23                        
        Add                                    %% good
        Label        -SCBooleanAnd-50-start    
        Label        -SCBooleanAnd-49-start    
        Label        -SCBooleanAnd-48-start    
        Label        -SCBooleanAnd-47-start    
        Label        -SCBooleanAnd-46-start    
        Label        -SCBooleanAnd-45-start    
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% elem1
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-45-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-45-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-45-arg2Start 
        PushD        $global-memory-block      
        PushI        17                        
        Add                                    %% elem2
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-45-arg2Done 
        Jump         -SCBooleanAnd-45-end      
        Label        -SCBooleanAnd-45-short-circuit-false 
        Label        -SCBooleanAnd-45-end      
        Nop                                    
        Label        -SCBooleanAnd-46-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-46-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-46-arg2Start 
        PushD        $global-memory-block      
        PushI        18                        
        Add                                    %% elem3
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-46-arg2Done 
        Jump         -SCBooleanAnd-46-end      
        Label        -SCBooleanAnd-46-short-circuit-false 
        Label        -SCBooleanAnd-46-end      
        Nop                                    
        Label        -SCBooleanAnd-47-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-47-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-47-arg2Start 
        PushD        $global-memory-block      
        PushI        19                        
        Add                                    %% elem4
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-47-arg2Done 
        Jump         -SCBooleanAnd-47-end      
        Label        -SCBooleanAnd-47-short-circuit-false 
        Label        -SCBooleanAnd-47-end      
        Nop                                    
        Label        -SCBooleanAnd-48-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-48-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-48-arg2Start 
        PushD        $global-memory-block      
        PushI        20                        
        Add                                    %% elem5
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-48-arg2Done 
        Jump         -SCBooleanAnd-48-end      
        Label        -SCBooleanAnd-48-short-circuit-false 
        Label        -SCBooleanAnd-48-end      
        Nop                                    
        Label        -SCBooleanAnd-49-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-49-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-49-arg2Start 
        PushD        $global-memory-block      
        PushI        21                        
        Add                                    %% elem6
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-49-arg2Done 
        Jump         -SCBooleanAnd-49-end      
        Label        -SCBooleanAnd-49-short-circuit-false 
        Label        -SCBooleanAnd-49-end      
        Nop                                    
        Label        -SCBooleanAnd-50-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-50-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-50-arg2Start 
        PushD        $global-memory-block      
        PushI        22                        
        Add                                    %% elem7
        LoadC                                  
        Nop                                    
        Label        -SCBooleanAnd-50-arg2Done 
        Jump         -SCBooleanAnd-50-end      
        Label        -SCBooleanAnd-50-short-circuit-false 
        Label        -SCBooleanAnd-50-end      
        StoreC                                 
        Label        -if-53-condition          
        Label        -compare-51-args-start    
        Label        -compare-51-arg1          
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        Label        -compare-51-arg2          
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% printEvery
        LoadI                                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% printEvery
        LoadI                                  
        Nop                                    
        Duplicate                              
        JumpFalse    $$i-divide-by-zero        
        Divide                                 
        Nop                                    
        Multiply                               
        Nop                                    
        Label        -compare-51-start         
        Subtract                               
        JumpFalse    -compare-51-true          
        Jump         -compare-51-false         
        Label        -compare-51-true          
        PushI        1                         
        Jump         -compare-51-join          
        Label        -compare-51-false         
        PushI        0                         
        Jump         -compare-51-join          
        Label        -compare-51-join          
        Label        -if-53-branch             
        JumpFalse    -if-53-false              
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        PushD        $global-memory-block      
        PushI        23                        
        Add                                    %% good
        LoadC                                  
        JumpTrue     -print-boolean-52-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-52-join    
        Label        -print-boolean-52-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-52-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        Jump         -if-53-end                
        Label        -if-53-false              
        Label        -if-53-end                
        Label        -if-56-condition          
        Label        -booleanNegate-54-args-start 
        Label        -booleanNegate-54-arg1    
        PushD        $global-memory-block      
        PushI        23                        
        Add                                    %% good
        LoadC                                  
        Nop                                    
        Label        -booleanNegate-54-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-54-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-54-end     
        Label        -if-56-branch             
        JumpFalse    -if-56-false              
        DLabel       -stringConstant-55--start 
        DataI        3                         type id for string
        DataI        9                         status for string
        DataI        5                         length
        DataC        98                        %% "bad! "
        DataC        97                        
        DataC        100                       
        DataC        33                        
        DataC        32                        
        DataC        0                         
        PushD        -stringConstant-55--start 
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        Jump         -if-56-end                
        Label        -if-56-false              
        Label        -if-56-end                
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% indx
        LoadI                                  
        Nop                                    
        PushI        1                         
        Nop                                    
        Add                                    
        Nop                                    
        StoreI                                 
        Jump         -while-22-condition       
        Label        -while-22-breakTarget     
        Label        -while-22-end             
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
