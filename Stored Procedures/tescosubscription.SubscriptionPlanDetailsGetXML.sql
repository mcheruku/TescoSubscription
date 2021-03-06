IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGetXML] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionPlanDetailsGetXML] 

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
	WarmUP Script:	Execute [tescosubscription].[subscriptionPlanDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		                                Change Description
	12/12/2012		Robin													        corrected SubscriptionPlanDetailsGetXML to SubscriptionPlanDetailsGetXMLL

*/

BEGIN
SET NOCOUNT ON

DECLARE @SlotXML XML
 
SELECT @SlotXML='<Slots>
  <Slot DOW="1" />
  <Slot DOW="2" />
  <Slot DOW="3" />
  <Slot DOW="4" />
  <Slot DOW="5" />
  <Slot DOW="6" />
  <Slot DOW="7" />
</Slots>'


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
	  ,PaymentInstallmentID		'PaymentInstallmentID'
	  ,CASE WHEN ISSlotRestricted = 1 THEN
		(SELECT [DOW] '@DOW'
		 FROM [tescosubscription].[SubscriptionPlanSlot]
			WHERE [SubscriptionPlanID] = @SubscriptionPlanID
			FOR XML PATH('Slot'),TYPE,root('Slots')	)
		ELSE
		 @SlotXML
		END 
FROM  [tescosubscription].[SubscriptionPlan] (NOLOCK)
WHERE [SubscriptionPlanID] = @SubscriptionPlanID
FOR XML PATH('SubscriptionPlan'),TYPE,root('SubscriptionPlans')	


END


GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionPlanDetailsGetXML]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGetXML]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsGetXML]  not created.',16,1)
		
	END
GO







