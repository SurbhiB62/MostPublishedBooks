/**
* @author            : Surbhi Bhati
* @description       : Comparator class to sort the book list.
**/
public class PublishedBookComparator implements Comparator<BookWrapperCls.Books> {
    
    public Integer compare(BookWrapperCls.Books book1, BookWrapperCls.Books book2) {
        
        //comparison started
        
        Integer result;
        if(book1?.getEdition() == null && book2?.getEdition() == null) {
            result = 0;
        } else if(book1?.getEdition() == null) { 
            result = -1; 
        } else if(book2?.getEdition() == null) {
            result = 1;
        } else if (book1.getEdition() < book2.getEdition()) {
            result = 1;
        } else if (book1.getEdition() > book2.getEdition()) {
            result = -1;
        } else {
            result = 0;  
        } 
        return result;
    }
}