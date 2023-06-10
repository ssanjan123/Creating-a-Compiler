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
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        74                        
        Label        $$main                    
        DLabel       str_0                     
        DataI        3                         
        DataI        9                         
        DataI        53                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        85                        
        DataC        112                       
        DataC        103                       
        DataC        114                       
        DataC        97                        
        DataC        100                       
        DataC        101                       
        DataC        100                       
        DataC        32                        
        DataC        84                        
        DataC        97                        
        DataC        110                       
        DataC        45                        
        DataC        49                        
        DataC        32                        
        DataC        67                        
        DataC        111                       
        DataC        109                       
        DataC        112                       
        DataC        105                       
        DataC        108                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        0                         
        PushD        str_0                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        DLabel       str_1                     
        DataI        3                         
        DataI        9                         
        DataI        27                        
        DataC        49                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        70                        
        DataC        108                       
        DataC        111                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        76                        
        DataC        105                       
        DataC        116                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        108                       
        DataC        0                         
        PushD        str_1                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% float_num
        PushF        1234.000000               
        StoreF                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% float_num
        LoadF                                  
        PushD        $print-format-float       
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_2                     
        DataI        3                         
        DataI        9                         
        DataI        27                        
        DataC        92                        
        DataC        110                       
        DataC        50                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        83                        
        DataC        116                       
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        76                        
        DataC        105                       
        DataC        116                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        108                       
        DataC        0                         
        PushD        str_2                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% str_lit
        DLabel       str_3                     
        DataI        3                         
        DataI        9                         
        DataI        12                        
        DataC        72                        
        DataC        101                       
        DataC        108                       
        DataC        108                       
        DataC        111                       
        DataC        32                        
        DataC        87                        
        DataC        111                       
        DataC        114                       
        DataC        108                       
        DataC        100                       
        DataC        33                        
        DataC        0                         
        PushD        str_3                     
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% str_lit
        LoadI                                  
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_4                     
        DataI        3                         
        DataI        9                         
        DataI        30                        
        DataC        92                        
        DataC        110                       
        DataC        51                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        67                        
        DataC        104                       
        DataC        97                        
        DataC        114                       
        DataC        97                        
        DataC        99                        
        DataC        116                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        76                        
        DataC        105                       
        DataC        116                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        108                       
        DataC        0                         
        PushD        str_4                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% char_lit
        PushI        65                        
        StoreI                                 
        PushD        $global-memory-block      
        PushI        13                        
        Add                                    %% char_octal
        PushI        61                        
        StoreI                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% char_lit
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        13                        
        Add                                    %% char_octal
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_5                     
        DataI        3                         
        DataI        9                         
        DataI        27                        
        DataC        92                        
        DataC        110                       
        DataC        52                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        85                        
        DataC        110                       
        DataC        97                        
        DataC        114                       
        DataC        121                       
        DataC        32                        
        DataC        79                        
        DataC        112                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        PushD        str_5                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        14                        
        Add                                    %% unary_test
        Label        -Operator-1-args          
        PushI        5                         
        Nop                                    
        StoreI                                 
        PushD        $global-memory-block      
        PushI        14                        
        Add                                    %% unary_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_6                     
        DataI        3                         
        DataI        9                         
        DataI        32                        
        DataC        92                        
        DataC        110                       
        DataC        53                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        65                        
        DataC        114                       
        DataC        105                       
        DataC        116                       
        DataC        104                       
        DataC        109                       
        DataC        101                       
        DataC        116                       
        DataC        105                       
        DataC        99                        
        DataC        32                        
        DataC        79                        
        DataC        112                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        PushD        str_6                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $global-memory-block      
        PushI        18                        
        Add                                    %% arith_test
        Label        -Operator-2-args          
        PushI        5                         
        PushI        3                         
        Multiply                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        22                        
        Add                                    %% div_test
        PushI        15                        
        PushI        3                         
        Duplicate                              
        JumpFalse    $$i-divide-by-zero        
        Divide                                 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        18                        
        Add                                    %% arith_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        22                        
        Add                                    %% div_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_7                     
        DataI        3                         
        DataI        9                         
        DataI        32                        
        DataC        92                        
        DataC        110                       
        DataC        54                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        67                        
        DataC        111                       
        DataC        109                       
        DataC        112                       
        DataC        97                        
        DataC        114                       
        DataC        105                       
        DataC        115                       
        DataC        111                       
        DataC        110                       
        DataC        32                        
        DataC        79                        
        DataC        112                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        PushD        str_7                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $global-memory-block      
        PushI        26                        
        Add                                    %% comp_test
        PushI        5                         
        PushI        3                         
        Subtract                               
        JumpNeg      -compare-3-true           
        Label        -compare-3-false          
        PushI        0                         
        Jump         -compare-3-join           
        Label        -compare-3-true           
        PushI        1                         
        Label        -compare-3-join           
        StoreI                                 
        PushD        $global-memory-block      
        PushI        26                        
        Add                                    %% comp_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        30                        
        Add                                    %% eq_test
        PushI        5                         
        PushI        3                         
        Subtract                               
        JumpFalse    -compare-4-true           
        Label        -compare-4-false          
        PushI        0                         
        Jump         -compare-4-join           
        Label        -compare-4-true           
        PushI        1                         
        Label        -compare-4-join           
        StoreI                                 
        PushD        $global-memory-block      
        PushI        30                        
        Add                                    %% eq_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        34                        
        Add                                    %% neq_test
        PushI        5                         
        PushI        3                         
        Subtract                               
        JumpTrue     -compare-5-true           
        Label        -compare-5-false          
        PushI        0                         
        Jump         -compare-5-join           
        Label        -compare-5-true           
        PushI        1                         
        Label        -compare-5-join           
        StoreI                                 
        PushD        $global-memory-block      
        PushI        34                        
        Add                                    %% neq_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_8                     
        DataI        3                         
        DataI        9                         
        DataI        24                        
        DataC        92                        
        DataC        110                       
        DataC        55                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        68                        
        DataC        101                       
        DataC        99                        
        DataC        108                       
        DataC        97                        
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        111                       
        DataC        110                       
        DataC        0                         
        PushD        str_8                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        38                        
        Add                                    %% const_test
        PushI        100                       
        StoreI                                 
        PushD        $global-memory-block      
        PushI        38                        
        Add                                    %% const_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        42                        
        Add                                    %% var_test
        PushI        200                       
        StoreI                                 
        PushD        $global-memory-block      
        PushI        42                        
        Add                                    %% var_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_9                     
        DataI        3                         
        DataI        9                         
        DataI        33                        
        DataC        92                        
        DataC        110                       
        DataC        56                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        65                        
        DataC        115                       
        DataC        115                       
        DataC        105                       
        DataC        103                       
        DataC        110                       
        DataC        109                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        32                        
        DataC        83                        
        DataC        116                       
        DataC        97                        
        DataC        116                       
        DataC        101                       
        DataC        109                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        0                         
        PushD        str_9                     
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        46                        
        Add                                    %% assign_test
        PushI        10                        
        StoreI                                 
        PushD        $global-memory-block      
        PushI        46                        
        Add                                    %% assign_test
        PushI        20                        
        StoreI                                 
        PushD        $global-memory-block      
        PushI        46                        
        Add                                    %% assign_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_10                    
        DataI        3                         
        DataI        9                         
        DataI        37                        
        DataC        92                        
        DataC        110                       
        DataC        57                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        80                        
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        116                       
        DataC        32                        
        DataC        83                        
        DataC        116                       
        DataC        97                        
        DataC        116                       
        DataC        101                       
        DataC        109                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        32                        
        DataC        119                       
        DataC        105                       
        DataC        116                       
        DataC        104                       
        DataC        32                        
        DataC        84                        
        DataC        97                        
        DataC        98                        
        DataC        0                         
        PushD        str_10                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_11                    
        DataI        3                         
        DataI        9                         
        DataI        7                         
        DataC        32                        
        DataC        72                        
        DataC        101                       
        DataC        108                       
        DataC        108                       
        DataC        111                       
        DataC        32                        
        DataC        0                         
        PushD        str_11                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-tab         
        Printf                                 
        DLabel       str_12                    
        DataI        3                         
        DataI        9                         
        DataI        7                         
        DataC        32                        
        DataC        87                        
        DataC        111                       
        DataC        114                       
        DataC        108                       
        DataC        100                       
        DataC        32                        
        DataC        0                         
        PushD        str_12                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_13                    
        DataI        3                         
        DataI        9                         
        DataI        24                        
        DataC        92                        
        DataC        110                       
        DataC        49                        
        DataC        48                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        69                        
        DataC        120                       
        DataC        112                       
        DataC        114                       
        DataC        101                       
        DataC        115                       
        DataC        115                       
        DataC        105                       
        DataC        111                       
        DataC        110                       
        DataC        0                         
        PushD        str_13                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $global-memory-block      
        PushI        50                        
        Add                                    %% expr_test
        Label        -Operator-7-args          
        PushI        10                        
        Label        -Operator-6-args          
        PushI        5                         
        PushI        2                         
        Add                                    
        Multiply                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        50                        
        Add                                    %% expr_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_14                    
        DataI        3                         
        DataI        9                         
        DataI        27                        
        DataC        92                        
        DataC        110                       
        DataC        49                        
        DataC        49                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        67                        
        DataC        97                        
        DataC        115                       
        DataC        116                       
        DataC        32                        
        DataC        79                        
        DataC        112                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        PushD        str_14                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $global-memory-block      
        PushI        54                        
        Add                                    %% cast_test
        PushF        12.340000                 
        ConvertI                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        54                        
        Add                                    %% cast_test
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_15                    
        DataI        3                         
        DataI        9                         
        DataI        27                        
        DataC        92                        
        DataC        110                       
        DataC        49                        
        DataC        49                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        67                        
        DataC        97                        
        DataC        115                       
        DataC        116                       
        DataC        32                        
        DataC        79                        
        DataC        112                       
        DataC        101                       
        DataC        114                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        PushD        str_15                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        PushI        5                         
        StoreI                                 
        PushD        $global-memory-block      
        PushI        62                        
        Add                                    %% a
        PushI        6                         
        StoreI                                 
        PushD        $global-memory-block      
        PushI        62                        
        Add                                    %% a
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_16                    
        DataI        3                         
        DataI        9                         
        DataI        21                        
        DataC        92                        
        DataC        110                       
        DataC        49                        
        DataC        51                        
        DataC        46                        
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        67                        
        DataC        111                       
        DataC        109                       
        DataC        109                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        0                         
        PushD        str_16                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        DLabel       str_17                    
        DataI        3                         
        DataI        9                         
        DataI        36                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        32                        
        DataC        69                        
        DataC        110                       
        DataC        100                       
        DataC        32                        
        DataC        111                       
        DataC        102                       
        DataC        32                        
        DataC        84                        
        DataC        101                       
        DataC        115                       
        DataC        116                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        61                        
        DataC        0                         
        PushD        str_17                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        PushF        1.000000                  
        StoreF                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        PushF        10.000000                 
        StoreF                                 
        DLabel       str_18                    
        DataI        3                         
        DataI        9                         
        DataI        8                         
        DataC        97                        
        DataC        32                        
        DataC        116                       
        DataC        104                       
        DataC        101                       
        DataC        110                       
        DataC        32                        
        DataC        98                        
        DataC        0                         
        PushD        str_18                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-8-true           
        Label        -compare-8-false          
        PushI        0                         
        Jump         -compare-8-join           
        Label        -compare-8-true           
        PushI        1                         
        Label        -compare-8-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-9-true           
        Label        -compare-9-false          
        PushI        1                         
        Jump         -compare-9-join           
        Label        -compare-9-true           
        PushI        0                         
        Label        -compare-9-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFZero    -compare-10-true          
        Label        -compare-10-false         
        PushI        0                         
        Jump         -compare-10-join          
        Label        -compare-10-true          
        PushI        1                         
        Label        -compare-10-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        ConvertI                               
        JumpTrue     -compare-11-true          
        Label        -compare-11-false         
        PushI        0                         
        Jump         -compare-11-join          
        Label        -compare-11-true          
        PushI        1                         
        Label        -compare-11-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-12-true          
        Label        -compare-12-false         
        PushI        0                         
        Jump         -compare-12-join          
        Label        -compare-12-true          
        PushI        1                         
        Label        -compare-12-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-13-true          
        Label        -compare-13-false         
        PushI        1                         
        Jump         -compare-13-join          
        Label        -compare-13-true          
        PushI        0                         
        Label        -compare-13-join          
        PushD        $print-format-integer     
        Printf                                 
        DLabel       str_19                    
        DataI        3                         
        DataI        9                         
        DataI        8                         
        DataC        98                        
        DataC        32                        
        DataC        116                       
        DataC        104                       
        DataC        101                       
        DataC        110                       
        DataC        32                        
        DataC        97                        
        DataC        0                         
        PushD        str_19                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-14-true          
        Label        -compare-14-false         
        PushI        0                         
        Jump         -compare-14-join          
        Label        -compare-14-true          
        PushI        1                         
        Label        -compare-14-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-15-true          
        Label        -compare-15-false         
        PushI        1                         
        Jump         -compare-15-join          
        Label        -compare-15-true          
        PushI        0                         
        Label        -compare-15-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        JumpFZero    -compare-16-true          
        Label        -compare-16-false         
        PushI        0                         
        Jump         -compare-16-join          
        Label        -compare-16-true          
        PushI        1                         
        Label        -compare-16-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        ConvertI                               
        JumpTrue     -compare-17-true          
        Label        -compare-17-false         
        PushI        0                         
        Jump         -compare-17-join          
        Label        -compare-17-true          
        PushI        1                         
        Label        -compare-17-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-18-true          
        Label        -compare-18-false         
        PushI        0                         
        Jump         -compare-18-join          
        Label        -compare-18-true          
        PushI        1                         
        Label        -compare-18-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        58                        
        Add                                    %% a
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-19-true          
        Label        -compare-19-false         
        PushI        1                         
        Jump         -compare-19-join          
        Label        -compare-19-true          
        PushI        0                         
        Label        -compare-19-join          
        PushD        $print-format-integer     
        Printf                                 
        DLabel       str_20                    
        DataI        3                         
        DataI        9                         
        DataI        8                         
        DataC        98                        
        DataC        32                        
        DataC        116                       
        DataC        104                       
        DataC        101                       
        DataC        110                       
        DataC        32                        
        DataC        98                        
        DataC        0                         
        PushD        str_20                    
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-20-true          
        Label        -compare-20-false         
        PushI        0                         
        Jump         -compare-20-join          
        Label        -compare-20-true          
        PushI        1                         
        Label        -compare-20-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-21-true          
        Label        -compare-21-false         
        PushI        1                         
        Jump         -compare-21-join          
        Label        -compare-21-true          
        PushI        0                         
        Label        -compare-21-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFZero    -compare-22-true          
        Label        -compare-22-false         
        PushI        0                         
        Jump         -compare-22-join          
        Label        -compare-22-true          
        PushI        1                         
        Label        -compare-22-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        ConvertI                               
        JumpTrue     -compare-23-true          
        Label        -compare-23-false         
        PushI        0                         
        Jump         -compare-23-join          
        Label        -compare-23-true          
        PushI        1                         
        Label        -compare-23-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFNeg     -compare-24-true          
        Label        -compare-24-false         
        PushI        0                         
        Jump         -compare-24-join          
        Label        -compare-24-true          
        PushI        1                         
        Label        -compare-24-join          
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        PushD        $global-memory-block      
        PushI        66                        
        Add                                    %% b
        LoadF                                  
        FSubtract                              
        JumpFPos     -compare-25-true          
        Label        -compare-25-false         
        PushI        1                         
        Jump         -compare-25-join          
        Label        -compare-25-true          
        PushI        0                         
        Label        -compare-25-join          
        PushD        $print-format-integer     
        Printf                                 
        Halt                                   
