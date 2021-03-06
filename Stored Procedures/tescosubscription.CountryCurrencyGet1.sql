IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CountryCurrencyGet1] 

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet1] not dropped.',16,1)
				
			END
	END
GO
CREATE PROCEDURE [tescosubscription].[CountryCurrencyGet1] 
AS

/*

	Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get all the Country Currencies
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [BOASubscription].[CountryCurrencyGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	12/06/2012		Robin							Correction ** CREATE PROCEDURE
	12/12/2012		Robin							Added WITH (NOLOCK)   
*/

BEGIN

	   SET NOCOUNT ON		
	
	   SELECT [CountryCurrencyID]  'CountryCurrencyID',
              [CountryCode]        'CountryCode',
              [CountryCurrency]    'CountryCurrency'        
	   FROM   [tescosubscription].[CountryCurrencyMap]	WITH (NOLOCK)      
END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CountryCurrencyGet1]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet1] not created.',16,1)
		
	END
GO



