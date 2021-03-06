set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] not dropped.',16,1)
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGet1] 
(
@SubscriptionPlanID INT
)

AS

/*

	Author:			Robin
	Date created:	29/11/2012
	Purpose:		To get list of subscriptionPlan details for given SubscriptionPlanID
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionPlanDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		                                               Change Description
	12/06/2012	     Robin	       Added where condition for subscriptionplanid	
	12/06/2012       Robin	       Correction Create Procedure
	

*/

BEGIN
SET NOCOUNT ON
DECLARE 
@ErrorMessage NVARCHAR(2048)


SELECT [SubscriptionPlanID]     'SubscriptionPlanID'
      ,[CountryCurrencyID]      'CountryCurrencyID'
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
	  ,PaymentInstallmentID		'PaymentInstallmentID'
	 
FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID


IF @@ROWCOUNT > 0 
BEGIN

IF EXISTS(SELECT 1 FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
			WHERE [SubscriptionPlanID] = @SubscriptionPlanID AND ISSlotRestricted=1)
	SELECT DOW FROM [tescosubscription].[SubscriptionPlanSlot] (NOLOCK)
	        WHERE [SubscriptionPlanID] = @SubscriptionPlanID
 
ELSE
	SELECT 1 DOW UNION ALL
	SELECT 2 DOW UNION ALL
	SELECT 3 DOW UNION ALL
	SELECT 4 DOW UNION ALL
	SELECT 5 DOW UNION ALL
	SELECT 6 DOW UNION ALL
	SELECT 7 DOW


END

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGet1] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet1]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGet1] not created.',16,1)
	END
GO








