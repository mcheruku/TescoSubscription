/*

	Author:			Robin
	Date created:	19-Dec-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionPlanSlot] and [tescosubscription].[SubscriptionPlan]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanSlot]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlanSlot_SubscriptionPlan')
			BEGIN

				
	ALTER TABLE [tescosubscription].[SubscriptionPlanSlot]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionPlanSlot_SubscriptionPlan] FOREIGN KEY([SubscriptionPlanID])
	REFERENCES [tescosubscription].[SubscriptionPlan] ([SubscriptionPlanID])

				ALTER TABLE [tescosubscription].[SubscriptionPlanSlot] CHECK CONSTRAINT [FK_SubscriptionPlanSlot_SubscriptionPlan]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_SubscriptionPlanSlot_SubscriptionPlan')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_SubscriptionPlanSlot_SubscriptionPlan] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionPlanSlot]/[tescosubscription].[SubscriptionPlan] does not exist.',16,1)
	END
GO
