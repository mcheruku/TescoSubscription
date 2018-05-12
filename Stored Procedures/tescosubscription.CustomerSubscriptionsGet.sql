IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet] not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsGet]
(
	@CustomerID BIGINT,
	@Top TINYINT =3
)
AS

/*

	Author:			Saminathan
	Date created:	03/08/2011
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerSubscriptionsGet] 111,''

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
    04 Aug 2011		saritha							SP name changed from  GetCustomerSubscriptions to CustomerSubscriptionsGet
	19 Aug 2011		Joji							Added the NextRenewalDate in select list
    20 Sep 2011    Sam M						    Added condition to filter inactive status subscription
	12 Mar 2013    Robin                            Added CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID			
*/

	BEGIN
	
	  SET NOCOUNT ON
		SELECT  TOP (@Top)
			CS.CustomerSubscriptionID  CustomerSubscriptionID,
			CS.SubscriptionPlanID	   PlanSubscriptionID,
			CS.SwitchTo				   SwitchTo,
			SP.PlanName				   PlanName,
			CS.CustomerPlanStartDate   SubscriptionStartDate,
			CS.CustomerPlanEndDate     SubscriptionEndDate,
			--CS.SubscriptionStatus,
			SM.StatusName              Status,
			SP.PlanName				   PlaneName,
			SP.PlanTenure			   PlanTenure,
			SP.PlanAmount			   PlanAmount,
			CS.NextRenewalDate		   NextRenewalDate,
			CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID						
		FROM tescosubscription.CustomerSubscription CS 
		INNER JOIN tescosubscription.SubscriptionPlan SP  ON  CS.CustomerID = @CustomerID and CS.SubscriptionStatus <> 15 AND CS.SubscriptionPlanID = SP.SubscriptionPlanID
		INNER JOIN tescosubscription.StatusMaster  SM  ON CS.SubscriptionStatus=SM.StatusId
		ORDER BY  CS.UTCUpdatedDateTime desc
	END
	
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet] not created.',16,1)
		
	END
GO


