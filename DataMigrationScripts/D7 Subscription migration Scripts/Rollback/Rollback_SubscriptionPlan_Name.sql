--Rollback
USE TescoSubscription
GO
/*
	Author:		Robin
	Created:	1/Apr/2014
	Purpose:	Rollback the active plan to the old plan name
*/
UPDATE TescoSubscription.SubscriptionPlan SET
PlanName = '6 Month Anytime Plan – Pay Monthly',PlanDescription = '6 Month Anytime Plan - Pay Monthly',UTCCreatedDateTime = GETUTCDATE(),
BasketValue = 40.00, PlanAmount = 60.00
WHERE SubscriptionPlanID = 8
GO 
UPDATE TescoSubscription.SubscriptionPlan SET
PlanName = '6 Month Midweek Plan – Pay Monthly',PlanDescription = '6 Month Midweek Plan- Pay Monthly',UTCCreatedDateTime = GETUTCDATE(),
BasketValue = 40.00,PlanAmount = 45.00
WHERE SubscriptionPlanID = 10

 