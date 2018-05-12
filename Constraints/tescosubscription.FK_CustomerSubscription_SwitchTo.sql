/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	15 Jan 2013		Robin		<TFS no.>		    Created the constraint 

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchTo')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_SwitchTo] FOREIGN KEY(SwitchTo)
REFERENCES [tescosubscription].[SubscriptionPlan] (SubscriptionPlanID)

ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_SwitchTo]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_SwitchTo')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_SwitchTo] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_SwitchTo] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_SwitchTo] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO

GO