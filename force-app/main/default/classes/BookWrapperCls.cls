/**
* @author            : Surbhi Bhati
* @description       : Wrapper class to get book Details from the Http Response.
**/
public class BookWrapperCls{
    
    public String Publisher;
    public List<Books> Books;
    
    public class Books {
        public String Author;
        public String Title;
        public Integer Edition;
        public String Publisher;
        
        public Books(String Author,String Title,Integer Edition,String Publisher){
            this.Author = Author;
            this.Title = Title;
            this.Edition = Edition;
            this.Publisher= Publisher;
        }
        
        public Integer getEdition() {return Edition;}
    }
    
}