        Label        -mem-manager-initialize   
        DLabel       $heap-start-ptr           
        DataZ        4                         
        DLabel       $heap-after-ptr           
        DataZ        4                         
        DLabel       $heap-first-free          
        DataZ        4                         
        DLabel       $mmgr-newblock-block      
        DataZ        4                         
        DLabel       $mmgr-newblock-size       
        DataZ        4                         
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
        DLabel       $print-format-float       
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
        DLabel       $array-print-start-label  
        DataC        91                        %% "["
        DataC        0                         
        DLabel       $array-print-end-label    
        DataC        93                        %% "]"
        DataC        0                         
        DLabel       $array-print-separator-label 
        DataC        44                        %% ", "
        DataC        32                        
        DataC        0                         
        DLabel       $print-format-newline     
        DataC        10                        %% "\n"
        DataC        0                         
        DLabel       $print-format-tab         
        DataC        9                         %% "\t"
        DataC        0                         
        DLabel       $print-format-space       
        DataC        32                        %% " "
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
        DLabel       $errors-int-divide-by-zero 
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
        PushD        $errors-int-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $errors-float-divide-by-zero 
        DataC        102                       %% "float divide by zero"
        DataC        108                       
        DataC        111                       
        DataC        97                        
        DataC        116                       
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
        PushD        $errors-float-divide-by-zero 
        Jump         $$general-runtime-error   
        Label        $$array-indexing          
        Duplicate                              
        JumpFalse    $$array-null-pointer-error 
        Duplicate                              
        PushI        16                        
        Add                                    
        LoadI                                  
        PushD        $array-index              
        LoadI                                  
        Subtract                               
        JumpNeg      $$array-index-out-of-bounds-error 
        PushI        20                        
        Add                                    
        Exchange                               
        PushI        4                         
        LoadI                                  
        Multiply                               
        Add                                    
        Return                                 
        DLabel       $errors-array-indexing-message 
        DataC        65                        %% "Array index out of bounds"
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
        Label        $$array-index-out-of-bounds-error 
        PushD        $errors-array-indexing-message 
        Jump         $$general-runtime-error   
        DLabel       $errors-array-null-pointer-message 
        DataC        78                        %% "Null pointer error"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        112                       
        DataC        111                       
        DataC        105                       
        DataC        110                       
        DataC        116                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $$array-null-pointer-error 
        PushD        $errors-array-null-pointer-message 
        Jump         $$general-runtime-error   
        DLabel       $array-base-address       
        DataZ        8                         
        DLabel       $array-length             
        DataZ        8                         
        DLabel       $array-index              
        DataZ        8                         
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        28                        
        Label        $$main                    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AA
        PushI        28                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-3                    
        DataI        0                         
        PushD        $arr-3                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        3                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        28                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-0                    
        DataI        0                         
        PushD        $arr-0                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        3                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        1                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        2                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        3                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Pop                                    
        PushD        $arr-0                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        24                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-1                    
        DataI        0                         
        PushD        $arr-1                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        2                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        5                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Pop                                    
        PushD        $arr-1                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        20                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-2                    
        DataI        0                         
        PushD        $arr-2                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        1                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        6                         
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Pop                                    
        PushD        $arr-2                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Pop                                    
        PushD        $arr-3                    
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% BB
        PushI        28                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-7                    
        DataI        0                         
        PushD        $arr-7                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        4                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        3                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        32                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-4                    
        DataI        0                         
        PushD        $arr-4                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        8                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        2                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushF        3.400000                  
        Nop                                    
        StoreF                                 
        PushI        8                         
        Add                                    
        Duplicate                              
        PushF        10.200000                 
        Nop                                    
        StoreF                                 
        PushI        8                         
        Add                                    
        Pop                                    
        PushD        $arr-4                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        32                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-5                    
        DataI        0                         
        PushD        $arr-5                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        8                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        2                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushF        7.300000                  
        Nop                                    
        StoreF                                 
        PushI        8                         
        Add                                    
        Duplicate                              
        PushF        6.660000                  
        Nop                                    
        StoreF                                 
        PushI        8                         
        Add                                    
        Pop                                    
        PushD        $arr-5                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        24                        
        Call         -mem-manager-allocate     
        Duplicate                              
        DLabel       $arr-6                    
        DataI        0                         
        PushD        $arr-6                    
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        5                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        0                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        8                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushI        1                         
        StoreI                                 
        PushI        4                         
        Add                                    
        Duplicate                              
        PushF        6.400000                  
        Nop                                    
        StoreF                                 
        PushI        8                         
        Add                                    
        Pop                                    
        PushD        $arr-6                    
        LoadI                                  
        Nop                                    
        StoreI                                 
        PushI        4                         
        Add                                    
        Pop                                    
        PushD        $arr-7                    
        LoadI                                  
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AA
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        0                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len0                      
        DataZ        8                         
        DLabel       index0                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len0                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index0                    
        PushI        0                         
        StoreI                                 
        Label        start_1                   
        Duplicate                              
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        index0                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index0                    
        Exchange                               
        StoreI                                 
        PushD        len0                      
        LoadI                                  
        PushD        index0                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_1                     
        PushI        4                         
        Add                                    
        PushD        index0                    
        LoadI                                  
        PushD        len0                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_1        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_1        
        Jump         start_1                   
        Label        end_1                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AA
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        1                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len1                      
        DataZ        8                         
        DLabel       index1                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len1                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index1                    
        PushI        0                         
        StoreI                                 
        Label        start_2                   
        Duplicate                              
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        index1                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index1                    
        Exchange                               
        StoreI                                 
        PushD        len1                      
        LoadI                                  
        PushD        index1                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_2                     
        PushI        4                         
        Add                                    
        PushD        index1                    
        LoadI                                  
        PushD        len1                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_2        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_2        
        Jump         start_2                   
        Label        end_2                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% AA
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        2                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len2                      
        DataZ        8                         
        DLabel       index2                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len2                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index2                    
        PushI        0                         
        StoreI                                 
        Label        start_3                   
        Duplicate                              
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        index2                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index2                    
        Exchange                               
        StoreI                                 
        PushD        len2                      
        LoadI                                  
        PushD        index2                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_3                     
        PushI        4                         
        Add                                    
        PushD        index2                    
        LoadI                                  
        PushD        len2                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_3        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_3        
        Jump         start_3                   
        Label        end_3                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% BB
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        0                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len3                      
        DataZ        8                         
        DLabel       index3                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len3                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index3                    
        PushI        0                         
        StoreI                                 
        Label        start_4                   
        Duplicate                              
        LoadF                                  
        PushD        $print-format-float       
        Printf                                 
        PushD        index3                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index3                    
        Exchange                               
        StoreI                                 
        PushD        len3                      
        LoadI                                  
        PushD        index3                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_4                     
        PushI        8                         
        Add                                    
        PushD        index3                    
        LoadI                                  
        PushD        len3                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_4        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_4        
        Jump         start_4                   
        Label        end_4                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% BB
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        1                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len4                      
        DataZ        8                         
        DLabel       index4                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len4                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index4                    
        PushI        0                         
        StoreI                                 
        Label        start_5                   
        Duplicate                              
        LoadF                                  
        PushD        $print-format-float       
        Printf                                 
        PushD        index4                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index4                    
        Exchange                               
        StoreI                                 
        PushD        len4                      
        LoadI                                  
        PushD        index4                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_5                     
        PushI        8                         
        Add                                    
        PushD        index4                    
        LoadI                                  
        PushD        len4                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_5        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_5        
        Jump         start_5                   
        Label        end_5                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% BB
        LoadI                                  
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        2                         
        Multiply                               
        PushI        16                        
        Add                                    
        Add                                    
        LoadI                                  
        DLabel       len5                      
        DataZ        8                         
        DLabel       index5                    
        DataZ        8                         
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        len5                      
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        $array-print-start-label  
        Printf                                 
        PushD        index5                    
        PushI        0                         
        StoreI                                 
        Label        start_6                   
        Duplicate                              
        LoadF                                  
        PushD        $print-format-float       
        Printf                                 
        PushD        index5                    
        LoadI                                  
        PushI        1                         
        Add                                    
        PushD        index5                    
        Exchange                               
        StoreI                                 
        PushD        len5                      
        LoadI                                  
        PushD        index5                    
        LoadI                                  
        Subtract                               
        JumpFalse    end_6                     
        PushI        8                         
        Add                                    
        PushD        index5                    
        LoadI                                  
        PushD        len5                      
        LoadI                                  
        Subtract                               
        JumpFalse    skip_comma_space_6        
        PushD        $array-print-separator-label 
        Printf                                 
        Label        skip_comma_space_6        
        Jump         start_6                   
        Label        end_6                     
        PushD        $array-print-end-label    
        Printf                                 
        Pop                                    
        PushD        $print-format-newline     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Halt                                   
        Label        -mem-manager-make-tags    
        DLabel       $mmgr-tags-size           
        DataZ        4                         
        DLabel       $mmgr-tags-start          
        DataZ        4                         
        DLabel       $mmgr-tags-available      
        DataZ        4                         
        DLabel       $mmgr-tags-nextptr        
        DataZ        4                         
        DLabel       $mmgr-tags-prevptr        
        DataZ        4                         
        DLabel       $mmgr-tags-return         
        DataZ        4                         
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
        DataZ        4                         
        DLabel       $mmgr-onetag-location     
        DataZ        4                         
        DLabel       $mmgr-onetag-available    
        DataZ        4                         
        DLabel       $mmgr-onetag-size         
        DataZ        4                         
        DLabel       $mmgr-onetag-pointer      
        DataZ        4                         
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
        DataZ        4                         
        DLabel       $mmgr-alloc-size          
        DataZ        4                         
        DLabel       $mmgr-alloc-current-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-size 
        DataZ        4                         
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
        DataZ        4                         
        DLabel       $mmgr-dealloc-block       
        DataZ        4                         
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
        DataZ        4                         
        DLabel       $mmgr-remove-block        
        DataZ        4                         
        DLabel       $mmgr-remove-prev         
        DataZ        4                         
        DLabel       $mmgr-remove-next         
        DataZ        4                         
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
