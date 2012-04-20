#import "CsvSchemaValidatorTest.h"

#import "DBTableValidator.h"

@implementation CsvSchemaValidatorTest

-(void)setUp
{
    schema_ = [ NSDictionary dictionaryWithObjectsAndKeys:
                 @"DATETIME", @"Date"
               , @"INTEGER" , @"Visits"
               , @"INTEGER" , @"Value"                            
               , @"VARCHAR" , @"FacetId1"
               , @"VARCHAR" , @"FacetId2"
               , @"VARCHAR" , @"FacetId3"                            
               , nil ];
    
    
    primaryKey_ = [ NSOrderedSet orderedSetWithObjects: 
                     @"Date"
                   , @"FacetId1"
                   , @"FacetId2"
                   , @"FacetId3"                                
                   , nil ];
}

-(void)testAnyNilSchemaLeadsToNO
{
    BOOL result_ = NO;
    
    {
        result_ = [ DBTableValidator csvSchema: nil
                            matchesTableSchema: schema_ ];
    
        STAssertFalse( result_, @"false expected" );
    }
    
    {
        result_ = [ DBTableValidator csvSchema: primaryKey_
                            matchesTableSchema: nil ];
        
        STAssertFalse( result_, @"false expected" );
    }


    {
        result_ = [ DBTableValidator csvSchema: primaryKey_
                            matchesTableSchema: schema_ ];
        
        STAssertTrue( result_, @"true expected" );
    }
}

@end