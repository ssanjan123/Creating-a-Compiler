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
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        20                        
        Label        $$main                    
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% g
        DLabel       str_0                     
        DataI        3                         
        DataI        9                         
        DataI        20                        
        DataC        116                       
        DataC        97                        
        DataC        110                       
        DataC        32                        
        DataC        99                        
        DataC        111                       
        DataC        109                       
        DataC        112                       
        DataC        105                       
        DataC        108                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        105                       
        DataC        115                       
        DataC        32                        
        DataC        116                       
        DataC        104                       
        DataC        101                       
        DataC        32                        
        DataC        0                         
        PushD        str_0                     
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% g
        DLabel       str_1                     
        DataI        3                         
        DataI        9                         
        DataI        10                        
        DataC        119                       
        DataC        104                       
        DataC        121                       
        DataC        32                        
        DataC        92                        
        DataC        110                       
        DataC        32                        
        DataC        119                       
        DataC        104                       
        DataC        121                       
        DataC        0                         
        PushD        str_1                     
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        PushI        6                         
        StoreI                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        PushI        2                         
        StoreI                                 
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% c
        PushI        2                         
        StoreI                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% d
        Label        -Operator-1-args          
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% c
        LoadI                                  
        Duplicate                              
        JumpFalse    $$i-divide-by-zero        
        Divide                                 
        Subtract                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% g
        LoadI                                  
        PushI        12                        
        Add                                    
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-tab         
        Printf                                 
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% d
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpNeg      -compare-2-true           
        Label        -compare-2-false          
        PushI        0                         
        Jump         -compare-2-join           
        Label        -compare-2-true           
        PushI        1                         
        Label        -compare-2-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpPos      -compare-3-true           
        Label        -compare-3-false          
        PushI        0                         
        Jump         -compare-3-join           
        Label        -compare-3-true           
        PushI        1                         
        Label        -compare-3-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpPos      -compare-4-true           
        Label        -compare-4-false          
        PushI        1                         
        Jump         -compare-4-join           
        Label        -compare-4-true           
        PushI        0                         
        Label        -compare-4-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpNeg      -compare-5-true           
        Label        -compare-5-false          
        PushI        1                         
        Jump         -compare-5-join           
        Label        -compare-5-true           
        PushI        0                         
        Label        -compare-5-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpFalse    -compare-6-true           
        Label        -compare-6-false          
        PushI        0                         
        Jump         -compare-6-join           
        Label        -compare-6-true           
        PushI        1                         
        Label        -compare-6-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% b
        LoadI                                  
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% a
        LoadI                                  
        Subtract                               
        JumpTrue     -compare-7-true           
        Label        -compare-7-false          
        PushI        0                         
        Jump         -compare-7-join           
        Label        -compare-7-true           
        PushI        1                         
        Label        -compare-7-join           
        PushD        $print-format-integer     
        Printf                                 
        PushD        $print-format-newline     
        Printf                                 
        Halt                                   
