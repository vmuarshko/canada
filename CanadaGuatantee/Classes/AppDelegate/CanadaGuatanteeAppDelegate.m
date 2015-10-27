//
//  CanadaGuatanteeAppDelegate.m
//  CanadaGuatantee
//
//  Created by root1 on 22/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CanadaGuatanteeAppDelegate.h"
#import "CanadaGuatanteeViewController.h"

@implementation CanadaGuatanteeAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize HUD;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	[self setLangDic];
	
	NSString *strLang = [[NSUserDefaults standardUserDefaults] objectForKey:@"setlang"];
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = viewController;

	if(strLang && [strLang length]>0){
		//[window addSubview:viewController.view];
		//[window makeKeyAndVisible];
	}else{
        //[window addSubview:viewController.view];
        //[window makeKeyAndVisible];
		UIAlertView *langAlert = [[UIAlertView alloc] initWithTitle:@"Choose your language" message:@"" delegate:self cancelButtonTitle:@"English" otherButtonTitles:@"French",nil];

		[langAlert show];
	}
}

-(void)setLangDic{

	NSDictionary *myLangDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"langDic"];
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
							 @"Nouvelles",@"News",
							 @"Produits",@"Products",
							 @"Calculatrices",@"Calculators",
							 @"Infolettres",@"Newsletter",
							 @"Contactez-nous",@"Contact",
							 @"Français",@"French",
							 @"",@"Please Wait...",
							 @"Extraction de données",@"Fetching Data",
							 @"Analyse de données",@"Parsing Data",
							 @"Attention!",@"Attention!",
							 @"Désolé! Pas de connexion Internet. S'il vous plaît essayez de nouveau.",@"Sorry! No internet connection available. Please try again.",
							 @"Une erreur de serveur s'est produite. S'il vous plaît essayez de nouveau.",@"A server error has occurred. Please try again.",
							 @"Attention!",@"Attention!",
							 @"Retour",@"Back",	
							 @"Siège social",@"Corporate Head Office",	
							 @"Lettre Nouvelles Inscrivez-vous",@"Newsletter Sign-up",	
							 @"CALCULATRICES",@"CALCULATORS",	
							 @"PRODUITS D'ASSURANCE",@"INSURANCE PRODUCTS",	
							 @"PRODUITS INSURANC",@"INSURANCE PRODUCTS",
							 @"CENTRE DE NOUVELLES",@"NEWS CENTRE",	
							 @"COMMUNIQUÉ DE NOUVELLES",@"NEWS RELEASES",
							 @"Calcul",@"Calculate",	
							 @"Calculatrice de versements hypothécaires",@"Mortgage Payment Calculator",	
							 @"Calculatrice de primes d'assurance",@"Insurance Premium Calculator",	
							 @"Pour s'inscrire",@"Sign-up",
							 @"Prêt-à-Ratio valeur",@"Loan-to-Value Ratio",
							 @"À prime unique",@"Single Premium",
							 @"Premium Top-Up",@"Top-Up Premium",
							 @"Taux d'assurance:",@"Insurance Rate:",
							 @"Veuillez s'il vous plaît remplir tous les champs.",@"Please ensure all fields are completed.",
							 @"Taux d'intérêt ne devrait pas dépasser 100.",@"Interest Rate should not exceed 100.",
							 @"Acompte doit pas dépasser 100.",@"Down Payment should not exceed 100.",
							 @"S'il vous plaît entrez le numéro valide.",@"Please enter valid number.",
							 @"Mail sendt.",@"Mail sent successfully.",
							 @"Undskyld! Nogle fejl opstod, Prøv venligst igen senere.",@"Sorry! Some error occurred, Please try again later.",
							 @"Merci de vous être inscrit(e) au service de nouvelles Canada Guaranty.",@"Thank you for subscribing to the Canada Guaranty newsletter.",
							 @"Une erreur inattendue s'est produite.",@"An unexpected error has occurred.",
							 @"Annuler",@"Cancel",
							 @"Réessayer",@"Retry",
							 @"Signature des",@"Signing up",
							 @"Prénom:",@"First Name:",
							 @"Nom:",@"Last Name:",
							 @"Adresse courriel:",@"Email:",
							 @"Province/Territoire:",@"Province/Territory:",
							 @"Société:",@"Company:",
							 @"Language préférée (Anglais/Français):",@"Preferred Language (English/French):",
							 @"S'il vous plaît entrer prénom.",@"Please enter first name.",
							 @"S'il vous plaît entrer nom.",@"Please enter last name.",
							 @"S'il vous plaît entrez votre adresse e-mail.",@"Please enter email address.",
							 @"S'il vous plaît entrez votre adresse e-mail valide.",@"Please enter valid email address.",
							 @"S'il vous plaît entrer province / territoire.",@"Please enter province/territory.",
							 @"S'il vous plaît entrer entreprise.",@"Please enter company.",
							 nil] ;
		[[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"langDic"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

	if(buttonIndex == 0){
		[[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"setlang"];
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"language"];
	}else{
		[[NSUserDefaults standardUserDefaults] setObject:@"French" forKey:@"setlang"];
		[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"language"];
	}
	//[window addSubview:viewController.view];
	//[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
