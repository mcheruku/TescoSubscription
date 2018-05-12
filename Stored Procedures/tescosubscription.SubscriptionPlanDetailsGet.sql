IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet]dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet]

(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Saritha kommineni
	Date created:	02 Aug 2011
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanDetailsGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    05/08/2011		Saritha k					    Added comments in the SP
	11/12/2012      Robin		                    Changed from subscriptionPlanDetailsGet to SubscriptionPlanDetailsGet

*/

BEGIN
SET NOCOUNT ON

SELECT [CountryCurrencyID]      'CountryCurrencyID'
      ,[BusinessID]				'BusinessID'
      ,[SubscriptionID]			'SubscriptionID'
      ,[PlanName]				'PlanName'
      ,[PlanDescription]	    'PlanDescription'
      ,[SortOrder]				'SortOrder'
      ,[PlanTenure]				'PlanTenure'
      ,[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
      ,[PlanEffectiveEndDate]	'PlanEffectiveEndDate'
      ,[PlanAmount]				'PlanAmount'
	  ,[TermConditions]         'TermConditions'
      ,[IsActive]			    'IsActive'
      ,[RecurringMonths]		'RecurringMonths'
      ,[PlanMaxUsage]		    'PlanMaxUsage'
      ,[BasketValue]            'BasketValue'
      ,[FreePeriod]             'FreePeriod'
FROM  [tescosubscription].[tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')	


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGet] TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet]created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet] not created.',16,1)
		
	END
GO


