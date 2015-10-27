//
//  GlossaryController.m
//  Jencor
//
//  Created by Teknowledge Software on 02/03/12.
//  Copyright (c) 2012 Teknowledge Software. All rights reserved.
//

#import "GlossaryController.h"
#import "GlossaryCell.h"

@implementation GlossaryController
@synthesize web;
@synthesize tbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];

    [self addCommonHeaderForView:@"Glossary" modal:NO showBackButton:YES showEmailButton:NO];
    arr=[[NSMutableArray alloc]init];
    arr=[self prepareData];
    
    if(!appDelegate.isIphone5)
    {
        CGRect frame = tbl.frame;
        frame.size.height = 290;
        tbl.frame = frame;
    }

    
    
}  

-(NSMutableArray *)prepareData
{
    
   NSMutableArray *arrMain=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    //For A
        [dic setObject:@"A" forKey:@"alpha"];
        NSMutableArray *arrSub=[[NSMutableArray alloc]init];
        NSMutableDictionary *subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Agreement of Purchase and Sales " forKey:@"title"];						
        [subdic setObject:@"The legal contract a purchaser and a seller go into. We recommend that you have your offer prepared by a professional realtor that has the knowledge and experience to satisfactorily protect you with the most suitable clauses and conditions." forKey:@"desc"];	
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Amortization Period" forKey:@"title"];						
        [subdic setObject:@"The number of years it takes to repay the entire amount of the financing based on a set of fixed payments." forKey:@"desc"];						

        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Appraisal " forKey:@"title"];						
        [subdic setObject:@"The process of determining the market value of a property." forKey:@"desc"];	
        
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Assets" forKey:@"title"];						
        [subdic setObject:@"What you own or can call upon. Often used in determining net worth or in securing financing." forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Assumption Agreement " forKey:@"title"];						
    [subdic setObject:@"A legal document signed by a buyer that requires the buyer assume responsibility for the obligations of an existing mortgage. If someone assumes your mortgage, make sure that you get a release from the mortgage company to ensure that you are no longer liable for the debt." forKey:@"desc"];	
        
        [arrSub addObject:subdic];
        [subdic release];
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    //For B
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"B" forKey:@"alpha"];

        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Blended Payments " forKey:@"title"];						
        [subdic setObject:@"Equal payments consisting of both an interest and a principal component. Typically, while the payment amount does not change, over time the principal portion increases, while the interest portion decreases." forKey:@"desc"];	
        [arrSub addObject:subdic];
        [subdic release];
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For C
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"C" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Canada Mortgage and Housing Corporation (CMHC) " forKey:@"title"];						
        [subdic setObject:@"CMHC is a federal Crown corporation that administers the National Housing Act (NHA). Among other services, they also insure mortgages for lenders that are greater than 80% of the purchase price or value of the home. The cost of that insurance is paid for by the borrower and is generally added to the mortgage amount. These mortgages are often referred to as \"Hi-Ratio\"mortgages." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Closed Mortgage " forKey:@"title"];						
        
        [subdic setObject:@"A mortgage that cannot be prepaid or renegotiated for a set period of time without penalties." forKey:@"desc"];
        
        [arrSub addObject:subdic];
        [subdic release];
         subdic=[[NSMutableDictionary alloc]init];

      [subdic setObject:@"Closing Date" forKey:@"title"];						
    
       [subdic setObject:@"The date on which the new owner takes possession of the property and the sale becomes final." forKey:@"desc"];
    
   [ arrSub addObject:subdic];
    [subdic release];
    subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Collateral " forKey:@"title"];						
        [subdic setObject:@"An asset, such as term deposit, Canada Savings Bond, or automobile, that you offer as security f" forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
         subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Conventional Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage up to 80% of the purchase price or the value of the property. A mortgage exceeding 80% is referred to as a Hi-Ratio mortgage and the lender will require insurance for that mortgage." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Credit Scoring " forKey:@"title"];						
        [subdic setObject:@"A system that assesses a borrower on a number of items, assigning points that are used to determine the borrower's credit worthiness." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For D
      
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"D" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Demand Loan " forKey:@"title"];						
        [subdic setObject:@"A loan where the balance must be repaid upon request." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Deposit " forKey:@"title"];						
        [subdic setObject:@"A sum of money deposited in trust by the purchaser on making an offer to purchase. When the offer is accepted by the vendor (seller), the deposit is held in trust by the listing real estate broker, lawyer, or notary until the closing of the sale, at which point it is given to the vendor. If a house does not close because of the purchaser's failure to comply with the terms set out in the offer, the purchaser forgoes the deposit, and it is given to the vendor as compensation for the breaking of the contract (the offer)." forKey:@"desc"];	
        [arrSub addObject:subdic];
        [subdic release];
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For E
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"E" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        
        [subdic setObject:@"Equity" forKey:@"title"];						
        [subdic setObject:@"The difference between the market value of the property and any outstanding mortgages registered against the property. This difference belongs to the owner of that property." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For F
    
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"F" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"First Mortgage " forKey:@"title"];						
        [subdic setObject:@"A debt registered against a property that has first call on that property." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Fixed Rate Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage for which the interest is set for the term of the mortgage." forKey:@"desc"];		
        [arrSub addObject:subdic];
        [subdic release];
       
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For G
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"G" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Gross Debt Service Ratio (GDS) " forKey:@"title"];						
        [subdic setObject:@"It is one of the mathematical calculations used by lenders to determine a borrower's capacity to repay a mortgage. It takes into account the mortgage payments, property taxes, approximate heating costs, and 50% of any condo fees, and this sum is then divided by the gross income of the applicants. Ratios up to 32% are acceptable." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Guarantor " forKey:@"title"];						
        [subdic setObject:@"A person with an established credit rating and sufficient earnings who guarantees to repay the loan for the borrower if the borrower does not." forKey:@"desc"];		
        
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For H
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"H" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"High-Ratio Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage that exceeds 80% of the purchase price or appraised value of the property. This type of mortgage must be insured." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Home Equity Line of Credit (HELOC)" forKey:@"title"];						
        [subdic setObject:@"A personal line of credit secured against the borrower's property. Generally, up to 75% of the purchase price or appraised value of the property is allowed to be borrowed with this product." forKey:@"desc"];						
        
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For I
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"I" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Interest Adjustment Date (IAD) " forKey:@"title"];						
       [subdic setObject:@"The date on which the mortgage term will begin. This date is usually the first day of the month following the closing. The interest cost for those days from the closing date to the first of the month are usually paid at closing. That is why it is always better to close your deal towards the end of the month." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Interest-Only Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage on which only the monthly interest cost is paid each month. The full principal remains outstanding. The payment is lower than an amortized mortgage since one is not paying any principal." forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
      //For J
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"J" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"No Items" forKey:@"title"];						
        [subdic setObject:@"" forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];

       
    
     //For K
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

     //For L
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

     //For M
    
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"I" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage is a loan that uses a piece of real estate as a security. Once that loan is paid-off, the lender provides a discharge for that mortgage." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Mortgagee " forKey:@"title"];						
        [subdic setObject:@"The financial institution or person (lender) who is lending the money using a mortgage." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];

        [subdic setObject:@"Mortgagor " forKey:@"title"];						
        [subdic setObject:@"The person who borrows the money using a mortgage." forKey:@"desc"];		
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];

    //For N
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

    
    //For O
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"O" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Open Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage that can be repaid at any time during the term without any penalty. For this convenience, the interest rate is higher than a closed mortgage. An open mortgage is a good option if you are planning to sell your property or pay off the mortgage entirely." forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For P
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"P" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"P.I.T. " forKey:@"title"];
        [subdic setObject:@"Principal, interest, and property tax due on a mortgage. If your down payment is greater than 25% of the purchase price or appraised value, the lender will allow you to make your own property tax payments" forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
    

        [subdic setObject:@"Portable Mortgage " forKey:@"title"];
        [subdic setObject:@"An existing mortgage that can be transferred to a new property. One would want to port their mortgage in order to avoid any penalties, or if the interest rate is much lower than the current rates." forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
    

        [subdic setObject:@"Prepayment Penalty " forKey:@"title"];							
        [subdic setObject:@"A fee charged a borrower by the lender when the borrower prepays all or part of a mortgage over and above the amount agreed upon. Although there is no law as to how a lender can charge you the penalty, a usual charge is the greater of the Interest Rate Differential (IRD) or 3 months interest." forKey:@"desc"];							
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        

        [subdic setObject:@"Principal " forKey:@"title"];							
        [subdic setObject:@"The original amount of a loan, before interest." forKey:@"desc"];			    [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];
    
    //For Q
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

    //For R
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"R" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Rate Commitment " forKey:@"title"];						
    [subdic setObject:@"The number of days the lender will guarantee the mortgage rate on a mortgage approval. This can vary from lender to lender anywhere from 30 to 120 days." forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Renewal" forKey:@"title"];						
    [subdic setObject:@"When the mortgage term has concluded, your mortgage is up for renewal. It is open at this time for prepayment in part or in full, then renew with same lender or transfer to another lender at no cost (we can arrange)." forKey:@"desc"];
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];
    //For S
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"S" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Second Mortgage " forKey:@"title"];						
    [subdic setObject:@"A debt registered against a property that is secured by a second charge on the property." forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Switch" forKey:@"title"];						
    [subdic setObject:@"To transfer an existing mortgage from one financial institution to another." forKey:@"desc"];
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

    
    //For T
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"T" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Term" forKey:@"title"];						
    [subdic setObject:@"The period of time the financing agreement covers. The terms available are: 6 month, 1 - 5, 7, and 10 year terms." forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"Total Debt Service (TDS) Ratio " forKey:@"title"];						
    [subdic setObject:@"It is the calculations used by lenders to determine a borrower's capacity to repay a mortgage. It takes into account the mortgage payments, property taxes, approximate heating costs, and 50% of any condo fees, and any other monthly obligations (i.e. personal loans, car payments, lines of credit, credit card debts, other mortgages, etc.), and this sum is then divided by the gross income of the applicants. Ratios up to 40 % are acceptable." forKey:@"desc"];
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];
    //For U
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

    //For V
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"V" forKey:@"alpha"];
        
        arrSub=[[NSMutableArray alloc]init];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Variable Rate Mortgage " forKey:@"title"];						
        [subdic setObject:@"A mortgage for which the interest rate fluctuates based on changes in prime." forKey:@"desc"];						
        [arrSub addObject:subdic];
        [subdic release];
        subdic=[[NSMutableDictionary alloc]init];
        [subdic setObject:@"Vendor Take Back (VTB) Mortgage" forKey:@"title"];						
        [subdic setObject:@"A mortgage provided by the vendor (seller) to the buyer." forKey:@"desc"];
        [arrSub addObject:subdic];
        [subdic release];
        
        [dic setObject:arrSub forKey:@"arrayData"];
        [arrSub release];
        [arrMain addObject:dic];
        [dic release];

    //For W
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];
    //For X
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];
    //For Y
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];
    //For Z
    dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"J" forKey:@"alpha"];
    
    arrSub=[[NSMutableArray alloc]init];
    subdic=[[NSMutableDictionary alloc]init];
    [subdic setObject:@"No Items" forKey:@"title"];						
    [subdic setObject:@"" forKey:@"desc"];						
    [arrSub addObject:subdic];
    [subdic release];
    
    [dic setObject:arrSub forKey:@"arrayData"];
    [arrSub release];
    [arrMain addObject:dic];
    [dic release];

    return arrMain;

}

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return [arr count];	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"] length]>240) {
          return 150.0;
    }
    else if([[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"] length]>200) {
        return 120.0;
    }

    else if([[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"] length]<2)
        return 30.0;
    else
        return 90.0;*/
    return [[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"] length]/2+40.0;
  
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section {
	return [[[arr objectAtIndex:section]objectForKey:@"arrayData"] count];
}

-(NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView {
	
        return ALPHA_ARRAY;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tbl.frame.size.width, 20)];
    [view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0]];
    
    CGRect frame=view.frame;
    frame.origin.x=10;
    frame.origin.y=5;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:frame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setFont:[UIFont boldSystemFontOfSize:15.0]];
    lbl.text=[ALPHA_ARRAY objectAtIndex:section];
    [lbl setTextColor:[UIColor whiteColor]];
    
    
    [view addSubview:lbl];
    
    return view;
    

}

/*- (NSString *) tableView: (UITableView*) tableView titleForHeaderInSection:(NSInteger)section {	
	return [ALPHA_ARRAY objectAtIndex:section];

}*/
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,tbl.frame.size.width,28.0)];
    tempView.backgroundColor=[UIColor greenColor];
	
		
	
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,290,30)];
    tempLabel.backgroundColor=[UIColor clearColor]; 
    tempLabel.shadowColor = [UIColor blackColor];
    tempLabel.shadowOffset = CGSizeMake(0,3);
    tempLabel.textColor = [UIColor whiteColor]; 
    tempLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
	//tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20.0];
    
	tempLabel.text=[ALPHA_ARRAY objectAtIndex:section];
;
    //tempLabel.textAlignment=UITextAlignmentCenter;
    [tempView addSubview:tempLabel];
    
    [tempLabel release];
    return tempView;    
}*/


- (UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
	
    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.textLabel.font=[UIFont fontWithName:@"Halvetica" size:10.0];
//    }
    static NSString *kCustomCellID = @"GlossaryCell";
	
	GlossaryCell *cell = (GlossaryCell *)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil) {
        
        UIViewController *controller=[[UIViewController alloc] initWithNibName:kCustomCellID bundle:nil];
        cell=(GlossaryCell *)controller.view;
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }

   
    cell.lblTitle.text=[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.lblDesc.text=[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"];
    NSLog(@"length is %d",[[[[[arr objectAtIndex:indexPath.section]objectForKey:@"arrayData"]objectAtIndex:indexPath.row]objectForKey:@"desc"] length]);
    // Configure the cell.
    return cell;

    return nil;
}


   /* web.backgroundColor=[UIColor clearColor];
    [self hideGradientBackground:web];
    
    appDelegate=(JencorAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [appDelegate showHUDinView:self.view andTitle:@"Please wait"];
    web.hidden=TRUE;
    
    NSString *HTML=[self getHTMLfromFile:@"glossary"];
    HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$BG_IMAGE$$$" withString:[NSString stringWithFormat:@"file://%@",JBUNDLE(@"glossary_bg.png")]];
    
    HTML=[HTML stringByReplacingOccurrencesOfString:@"$$$TOP_IMAGE$$$" withString:[NSString stringWithFormat:@"file://%@",JBUNDLE(@"glossary_header.png")]];
    
    [web loadHTMLString:HTML baseURL:nil];
    
    
    //[web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"glossary" ofType:@"html"] isDirectory:NO]]];
    
    
    
    isFetchingData=FALSE;   
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if(!isFetchingData){
        [appDelegate killHUD];
        webView.hidden=FALSE;
        [Utility fadeView:webView];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [appDelegate killHUD];
    
    if(isFetchingData)
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"There was some network error, please try again!"];
    
} */

- (void)viewDidUnload
{
    [self setWeb:nil];
    [self setTbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [web release];
    [tbl release];
    [super dealloc];
}

-(float) calculateCellheight:(NSString *)strText
{
    
    
}

/*- (IBAction)btnIndexAction:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    
    [web stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"fireOnclick(%@);",btn.currentTitle]];
    
    NSLog(@"index %@",btn.currentTitle);
}*/
@end
