
-- Rollback
/*
	Author:		Robin
	Created:	1/Apr/2014
	Purpose:	Rollback the deactivated plans to active status and change the plan end date 
*/

USE TescoSubscription
GO
Update TescoSubscription.SubscriptionPlan SET
IsActive = 1,PlanEffectiveEndDate= '10/31/2018',UTCUpdatedDateTime = GETUTCDATE()
WHERE SubscriptionPlanID IN (1,2,5,6,7,9)
