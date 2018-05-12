/*

	Created By:		Robin
	Date created:	05-dec-2012
	Purpose:		Rollback table tescosubscription.SubscriptionPlan [Script for current release]

	--Modifications History--
	Changed On         Changed By        Defect           Change Description
    1 Jul 2013         Robin                              Rollback for plan name alter
*/




--------------- Rollback Alter column [PlanName] ------------------------

IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'SubscriptionPlan'
				AND COLUMN_NAME         = 'PlanName'
                AND CHARACTER_OCTET_LENGTH = 50)
               
BEGIN  
ALTER TABLE [tescosubscription].[SubscriptionPlan]
ALTER COLUMN [PlanName] VARCHAR(30) NOT NULL

     
PRINT 'Column tescosubscription.SubscriptionPlan.PlanName is Altered'
END
GO
