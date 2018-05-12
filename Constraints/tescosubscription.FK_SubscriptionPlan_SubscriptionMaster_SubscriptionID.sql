/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionMaster] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID')
			BEGIN

				ALTER TABLE [tescosubscription].[SubscriptionPlan]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] FOREIGN KEY([SubscriptionID])
				REFERENCES [tescosubscription].[SubscriptionMaster] ([SubscriptionID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[SubscriptionPlan] CHECK CONSTRAINT [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlan_SubscriptionMaster_SubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionMaster]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
