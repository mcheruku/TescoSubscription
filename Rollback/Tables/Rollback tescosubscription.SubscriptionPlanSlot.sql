/*

	Author:			Robin
	Date created:	04-DEC-2012
	Purpose:		Rollback Table [tescosubscription].[SubscriptionPlanSlot]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	05 Aug 2013	    Robin	                        rollback for the PK constraint 

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]',N'U') IS NOT NULL
	BEGIN

		ALTER TABLE [tescosubscription].[SubscriptionPlanSlot] DROP  CONSTRAINT PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot].[PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Primary Key PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL -Primary Key PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Primary Key PK_SubscriptionPlanSlot_SubscriptionPlanID_DOW does not exist.'
	END
GO
