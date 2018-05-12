/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[SubscriptionPlan] and [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchTo')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchTo] FOREIGN KEY(SwitchTo)
REFERENCES [tescosubscription].[SubscriptionPlan] (SubscriptionPlanID)

ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchTo]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchTo')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchTo] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[SubscriptionPlan]/[tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16,1)
	END
GO

GO