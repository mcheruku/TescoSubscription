--Rollin 
/*
	Author:		Robin
	Created:	1/Apr/2014
	Purpose:	Deactivate the Plans and set the planenddate to todays date
*/
USE TescoSubscription
GO
Update TescoSubscription.SubscriptionPlan SET
IsActive = 0,PlanEffectiveEndDate= GETUTCDATE(),UTCUpdatedDateTime = GETUTCDATE()
WHERE SubscriptionPlanID IN (1,2,5,6,7,9)


 


 
