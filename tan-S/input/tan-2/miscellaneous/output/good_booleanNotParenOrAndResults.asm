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
        DataZ        0                         
        Label        $$main                    
        Label        -SCBooleanAnd-3-start     
        Label        -booleanNegate-2-args-start 
        Label        -booleanNegate-2-arg1     
        Label        -SCBooleanOr-1-start      
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-1-arg1Done   
        Duplicate                              
        JumpTrue     -SCBooleanOr-1-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-1-arg2Start  
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-1-arg2Done   
        Jump         -SCBooleanOr-1-end        
        Label        -SCBooleanOr-1-short-circuit-true 
        Label        -SCBooleanOr-1-end        
        Nop                                    
        Label        -booleanNegate-2-start    
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-2-end      
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-2-end      
        Nop                                    
        Label        -SCBooleanAnd-3-arg1Done  
        Duplicate                              
        JumpFalse    -SCBooleanAnd-3-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-3-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanAnd-3-arg2Done  
        Jump         -SCBooleanAnd-3-end       
        Label        -SCBooleanAnd-3-short-circuit-false 
        Label        -SCBooleanAnd-3-end       
        JumpTrue     -print-boolean-4-true     
        PushD        $boolean-false-string     
        Jump         -print-boolean-4-join     
        Label        -print-boolean-4-true     
        PushD        $boolean-true-string      
        Label        -print-boolean-4-join     
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-7-start     
        Label        -booleanNegate-6-args-start 
        Label        -booleanNegate-6-arg1     
        Label        -SCBooleanOr-5-start      
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-5-arg1Done   
        Duplicate                              
        JumpTrue     -SCBooleanOr-5-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-5-arg2Start  
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-5-arg2Done   
        Jump         -SCBooleanOr-5-end        
        Label        -SCBooleanOr-5-short-circuit-true 
        Label        -SCBooleanOr-5-end        
        Nop                                    
        Label        -booleanNegate-6-start    
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-6-end      
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-6-end      
        Nop                                    
        Label        -SCBooleanAnd-7-arg1Done  
        Duplicate                              
        JumpFalse    -SCBooleanAnd-7-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-7-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanAnd-7-arg2Done  
        Jump         -SCBooleanAnd-7-end       
        Label        -SCBooleanAnd-7-short-circuit-false 
        Label        -SCBooleanAnd-7-end       
        JumpTrue     -print-boolean-8-true     
        PushD        $boolean-false-string     
        Jump         -print-boolean-8-join     
        Label        -print-boolean-8-true     
        PushD        $boolean-true-string      
        Label        -print-boolean-8-join     
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-11-start    
        Label        -booleanNegate-10-args-start 
        Label        -booleanNegate-10-arg1    
        Label        -SCBooleanOr-9-start      
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-9-arg1Done   
        Duplicate                              
        JumpTrue     -SCBooleanOr-9-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-9-arg2Start  
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-9-arg2Done   
        Jump         -SCBooleanOr-9-end        
        Label        -SCBooleanOr-9-short-circuit-true 
        Label        -SCBooleanOr-9-end        
        Nop                                    
        Label        -booleanNegate-10-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-10-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-10-end     
        Nop                                    
        Label        -SCBooleanAnd-11-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-11-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-11-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanAnd-11-arg2Done 
        Jump         -SCBooleanAnd-11-end      
        Label        -SCBooleanAnd-11-short-circuit-false 
        Label        -SCBooleanAnd-11-end      
        JumpTrue     -print-boolean-12-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-12-join    
        Label        -print-boolean-12-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-12-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-15-start    
        Label        -booleanNegate-14-args-start 
        Label        -booleanNegate-14-arg1    
        Label        -SCBooleanOr-13-start     
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-13-arg1Done  
        Duplicate                              
        JumpTrue     -SCBooleanOr-13-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-13-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-13-arg2Done  
        Jump         -SCBooleanOr-13-end       
        Label        -SCBooleanOr-13-short-circuit-true 
        Label        -SCBooleanOr-13-end       
        Nop                                    
        Label        -booleanNegate-14-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-14-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-14-end     
        Nop                                    
        Label        -SCBooleanAnd-15-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-15-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-15-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanAnd-15-arg2Done 
        Jump         -SCBooleanAnd-15-end      
        Label        -SCBooleanAnd-15-short-circuit-false 
        Label        -SCBooleanAnd-15-end      
        JumpTrue     -print-boolean-16-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-16-join    
        Label        -print-boolean-16-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-16-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-19-start    
        Label        -booleanNegate-18-args-start 
        Label        -booleanNegate-18-arg1    
        Label        -SCBooleanOr-17-start     
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-17-arg1Done  
        Duplicate                              
        JumpTrue     -SCBooleanOr-17-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-17-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-17-arg2Done  
        Jump         -SCBooleanOr-17-end       
        Label        -SCBooleanOr-17-short-circuit-true 
        Label        -SCBooleanOr-17-end       
        Nop                                    
        Label        -booleanNegate-18-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-18-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-18-end     
        Nop                                    
        Label        -SCBooleanAnd-19-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-19-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-19-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanAnd-19-arg2Done 
        Jump         -SCBooleanAnd-19-end      
        Label        -SCBooleanAnd-19-short-circuit-false 
        Label        -SCBooleanAnd-19-end      
        JumpTrue     -print-boolean-20-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-20-join    
        Label        -print-boolean-20-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-20-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-23-start    
        Label        -booleanNegate-22-args-start 
        Label        -booleanNegate-22-arg1    
        Label        -SCBooleanOr-21-start     
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-21-arg1Done  
        Duplicate                              
        JumpTrue     -SCBooleanOr-21-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-21-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-21-arg2Done  
        Jump         -SCBooleanOr-21-end       
        Label        -SCBooleanOr-21-short-circuit-true 
        Label        -SCBooleanOr-21-end       
        Nop                                    
        Label        -booleanNegate-22-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-22-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-22-end     
        Nop                                    
        Label        -SCBooleanAnd-23-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-23-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-23-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanAnd-23-arg2Done 
        Jump         -SCBooleanAnd-23-end      
        Label        -SCBooleanAnd-23-short-circuit-false 
        Label        -SCBooleanAnd-23-end      
        JumpTrue     -print-boolean-24-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-24-join    
        Label        -print-boolean-24-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-24-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-27-start    
        Label        -booleanNegate-26-args-start 
        Label        -booleanNegate-26-arg1    
        Label        -SCBooleanOr-25-start     
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-25-arg1Done  
        Duplicate                              
        JumpTrue     -SCBooleanOr-25-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-25-arg2Start 
        PushI        1                         
        Nop                                    
        Label        -SCBooleanOr-25-arg2Done  
        Jump         -SCBooleanOr-25-end       
        Label        -SCBooleanOr-25-short-circuit-true 
        Label        -SCBooleanOr-25-end       
        Nop                                    
        Label        -booleanNegate-26-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-26-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-26-end     
        Nop                                    
        Label        -SCBooleanAnd-27-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-27-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-27-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanAnd-27-arg2Done 
        Jump         -SCBooleanAnd-27-end      
        Label        -SCBooleanAnd-27-short-circuit-false 
        Label        -SCBooleanAnd-27-end      
        JumpTrue     -print-boolean-28-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-28-join    
        Label        -print-boolean-28-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-28-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        32                        
        PushD        $print-format-character   
        Printf                                 
        Label        -SCBooleanAnd-31-start    
        Label        -booleanNegate-30-args-start 
        Label        -booleanNegate-30-arg1    
        Label        -SCBooleanOr-29-start     
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-29-arg1Done  
        Duplicate                              
        JumpTrue     -SCBooleanOr-29-short-circuit-true 
        Pop                                    
        Label        -SCBooleanOr-29-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanOr-29-arg2Done  
        Jump         -SCBooleanOr-29-end       
        Label        -SCBooleanOr-29-short-circuit-true 
        Label        -SCBooleanOr-29-end       
        Nop                                    
        Label        -booleanNegate-30-start   
        BNegate                                
        Duplicate                              
        JumpFalse    -booleanNegate-30-end     
        Pop                                    
        PushI        1                         
        Label        -booleanNegate-30-end     
        Nop                                    
        Label        -SCBooleanAnd-31-arg1Done 
        Duplicate                              
        JumpFalse    -SCBooleanAnd-31-short-circuit-false 
        Pop                                    
        Label        -SCBooleanAnd-31-arg2Start 
        PushI        0                         
        Nop                                    
        Label        -SCBooleanAnd-31-arg2Done 
        Jump         -SCBooleanAnd-31-end      
        Label        -SCBooleanAnd-31-short-circuit-false 
        Label        -SCBooleanAnd-31-end      
        JumpTrue     -print-boolean-32-true    
        PushD        $boolean-false-string     
        Jump         -print-boolean-32-join    
        Label        -print-boolean-32-true    
        PushD        $boolean-true-string      
        Label        -print-boolean-32-join    
        PushD        $print-format-boolean     
        Printf                                 
        PushI        10                        
        PushD        $print-format-character   
        Printf                                 
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