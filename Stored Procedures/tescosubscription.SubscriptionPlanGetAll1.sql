IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanGetAll1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll1] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanGetAll1]


AS

/*

	Author:			Robin John
	Date created:	05 Dec 2012
	Purpose:		To get all SubscriptionPlans
	Behaviour:		How does this procedure actually work
	 
	Called by:		<BOA>
	Script:	Execute [tescosubscription].[SubscriptionPlanGetAll1] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    12/06/2012		Robin							Correction **CREATE PROCEDURE
	13/12/2012		Robin							Granted permissions
*/
BEGIN 

SET NOCOUNT ON

SELECT [SubscriptionPlanID] 
      ,[CountryCurrencyID]       
	  ,[BusinessID]				 
	  ,[SubscriptionID]			 
	  ,[PlanName]				 
	  ,[PlanDescription]	    
	  ,[SortOrder]				 
	  ,[PlanTenure]				 
	  ,[PlanEffectiveStartDate]  
	  ,[PlanEffectiveEndDate]	 
	  ,[PlanAmount]				 
	  ,[TermConditions]         
	  ,[IsActive]			    
	  ,[RecurringMonths]		 
	  ,[PlanMaxUsage]		    
	  ,[BasketValue]             
	  ,[FreePeriod]              
	  ,[PaymentInstallmentID]	 
		 
FROM    [tescosubscription].[tescosubscription].[SubscriptionPlan] (NOLOCK) 

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanGetAll1]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll1] not created.',16,1)
		
	END
GO







 
