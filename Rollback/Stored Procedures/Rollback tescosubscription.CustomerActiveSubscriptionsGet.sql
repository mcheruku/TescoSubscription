/***************************************************************************************************

      Created By:	Navdeep B. Singh
      Date created:	12-March-2014
      Purpose:		[Rollback] Script for tescosubscription.CustomerActiveSubscriptionsGet
      
    --Modifications History--
 
      Changed On   Changed By  Defect   Change Description      No. of Changes
	  
  
****************************************************************************************************/

IF OBJECT_ID('[tescosubscription].[CustomerActiveSubscriptionsGet]','P') IS NOT NULL
BEGIN 

	DROP PROCEDURE [tescosubscription].[CustomerActiveSubscriptionsGet] 

	IF OBJECT_ID('[tescosubscription].[CustomerActiveSubscriptionsGet]') IS NULL
	BEGIN
		PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerActiveSubscriptionsGet] - dropped'
	END
	ELSE
	BEGIN
		RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerActiveSubscriptionsGet] - was not dropped',16,1)
	END
END
ELSE
BEGIN
	PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerActiveSubscriptionsGet] not exists'
END
GO
