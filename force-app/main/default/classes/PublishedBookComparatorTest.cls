/**
@author            : Surbhi Bhati
@description       : Test class for PublishedBookComparator
**/

@isTest
public class PublishedBookComparatorTest {
    @IsTest
    static void testComparator() {
        // Creating book list with different edition values
        List<BookWrapperCls.Books> bookList = new List<BookWrapperCls.Books>();
        bookList.add(new BookWrapperCls.Books('Robert C. Martin', 'xyz', 200000, 'X publications'));
        bookList.add(new BookWrapperCls.Books('Martin', 'mt', 6500000, 'Y publications'));
        bookList.add(new BookWrapperCls.Books('Kent Beck', 'abc', null, 'Z publications'));
        bookList.add(new BookWrapperCls.Books('Fowler', 'refactor', 500000, 'A publications'));
        bookList.add(new BookWrapperCls.Books('Uncle Bob', 'clean code', 500000, 'B publications'));
        
        // Instantiate comparator
        PublishedBookComparator editionCompare = new PublishedBookComparator();
        
        // Test cases
        System.assertEquals(1, editionCompare.compare(bookList[0], bookList[1]), 'Expected result: 1');
        System.assertEquals(-1, editionCompare.compare(bookList[2], bookList[0]), 'Expected result: -1');
        
        
        // Sorting the list to test actual sort behavior
        bookList.sort(editionCompare);
        System.debug('Sorted book list: ' + bookList);
    }
}