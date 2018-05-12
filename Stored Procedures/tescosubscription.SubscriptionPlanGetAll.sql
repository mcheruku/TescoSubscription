IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanGetAll] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[SubscriptionPlanGetAll]


AS

/*

	Author:			Saritha kommineni
	Date created:	02 Aug 2011
	Purpose:		To get all SubscriptionPlans
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanGetAll] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    05/08/2011		Ravi Paladugu					added [PlanEffectiveStartDate],[PlanEffectiveEndDate],[IsActive],[SortOrder] in select list
	05/08/2011		Ravi Paladugu					added Order by clause for SortOrder

*/
BEGIN 

SET NOCOUNT ON

SELECT	SP.[SubscriptionPlanID] 'SubscriptionPlanID'
		,SP.[PlanName]   'PlanName'
		,SP.[PlanTenure] 'PlanTenure'
		,SP.[PlanAmount] 'PlanAmount'
		,BM.[BusinessName] 'BusinessType'
        ,SM.[SubscriptionName]  'SubscriptionType'
		,SP.[PlanEffectiveStartDate] 'PlanEffectiveStartDate'
		,SP.[PlanEffectiveEndDate] 'PlanEffectiveEndDate'
		,SP.[IsActive] 'IsActive'
		,SP.[SortOrder] 'SortOrder'
FROM    [tescosubscription].[tescosubscription].[SubscriptionPlan] SP (NOLOCK)
INNER JOIN [tescosubscription].[tescosubscription].[BusinessMaster] BM  (NOLOCK)
ON		SP.[BusinessID]= BM.[BusinessID] 
INNER JOIN [tescosubscription].[tescosubscription].[SubscriptionMaster] SM  (NOLOCK)
ON      SP.[SubscriptionID]= SM.[SubscriptionID]
order by SP.[SortOrder]
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanGetAll]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll] not created.',16,1)
		
	END
GO
