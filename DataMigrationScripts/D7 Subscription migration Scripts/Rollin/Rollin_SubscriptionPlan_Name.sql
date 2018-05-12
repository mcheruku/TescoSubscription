--Rollin 

USE TescoSubscription
GO
/*
	Author:		Robin
	Created:	1/Apr/2014
	Purpose:	Change The old plan name which are active 
*/
UPDATE TescoSubscription.SubscriptionPlan SET
PlanName = 'Anytime 6 Months',PlanDescription = 'Anytime 6 Months',UTCUpdatedDateTime = GETUTCDATE(),BasketValue = 25.00,PlanAmount = 36.00
WHERE SubscriptionPlanID = 8
GO
UPDATE TescoSubscription.SubscriptionPlan SET
PlanName = 'Midweek 6 Months',PlanDescription = 'Midweek 6 Months',UTCUpdatedDateTime = GETUTCDATE(),BasketValue = 25.00,PlanAmount = 18.00
WHERE SubscriptionPlanID = 10

 



 



 