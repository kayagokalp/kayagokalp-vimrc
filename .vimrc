call plug#begin('~/.vim/plugged')

Plug 'https://github.com/bfrg/vim-cpp-modern'

call plug#end()
set number 
syntax on
set backspace=indent,eol,start
"C++ Class Generator                                                                                                    
 function! Class(ClassName)                                                                                              
    "==================  editing header file =====================                                                       
     let header = a:ClassName.".h"                                                                                                                                                                                                                                                                                        
     :vsp %:h/.h                                                                                                                                                                                                                             
     call append(0,"#ifndef ".toupper(a:ClassName)."_H")                                                                 
     call append(1,"#define ".toupper(a:ClassName)."_H")                                                           
     call append(2," ")                                                                                                  
     call append(3,"class ".a:ClassName )                                                                                
     call append(4, "{")                                                                                                 
     call append(5, "   public:")                                                                                        
     call append(6, "      ".a:ClassName."();")                                                                          
     call append(7, "      virtual ~".a:ClassName."();")                                                                 
     call append(8, "   protected:")                                                                                     
     call append(9, "   private:")                                                                                       
     call append(10, "};")                                                                                               
     call append(11,"#endif // ".toupper(a:ClassName)."_H")                                                              
     :execute 'write' header                                                                                             
   "================== editing source file ========================                                                      
     let src    = a:ClassName.".cpp"                                                                                     
     :vsp %:h/.cpp                                                                                                                                                                                                                     
     call append(0,"#include ".a:ClassName.".h")                                                                          
     call append(1," ")                                                                                                   
     call append(2,a:ClassName."::".a:ClassName."()")                                                                           
     call append(3,"{")                                                                                                   
     call append(4,"//ctor ")                                                                                             
     call append(5,"}")                                                                                                   
     call append(6," ")                                                                                                   
     call append(7," ")                                                                                                   
     call append(8,a:ClassName."::~".a:ClassName."()")                                                                         
     call append(9,"{")                                                                                                   
     call append(10,"//dtor ")                                                                                            
     call append(11,"}")                                                                                                  
     :execute 'write' src
endfunction
map <F2> :call TitleDet()<cr>
 function AddTitle()
     call append(1,"//# ******************************************************")
     call append(2,"//# Author       : kayagokalp ")
     call append(3,"//# Last modified: ".strftime("%Y-%m-%d %H:%M"))
     call append(4,"//# Email        : kayagokalp@sabanciuniv.edu")
     call append(6,"//# Filename     : ".expand("%:t"))
     call append(7,"//# Description  : ")
     call append(8,"//# ******************************************************")
     echohl WarningMsg | echo "Successful in adding copyright." | echohl None
 endf
 
 function UpdateTitle()
      normal m'
      execute '/# Last modified/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
      normal ''
      normal mk
      execute '/# Filename/s@:.*$@\=":\t".expand("%:t")@'
      execute "noh"
      normal 'k
      echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
 endfunction
 
 function TitleDet()
     let n=1
     while n < 10
         let line = getline(n)
         if line =~ '^\#\s*\S*Last\smodified\S*.*$'
             call UpdateTitle()
             return
         endif
         let n = n + 1
     endwhile
     call AddTitle()
 endfunction
