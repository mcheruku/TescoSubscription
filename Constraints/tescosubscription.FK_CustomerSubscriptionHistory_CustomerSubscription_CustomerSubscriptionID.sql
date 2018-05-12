/*

	Author:			Saritha Kommineni
	Date created:	14-10-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerSubscription] and [tescosubscription].[CustomerSubscriptionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
 
				IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
					OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
					BEGIN
						IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID')
							BEGIN

								ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
								REFERENCES [tescosubscription].[CustomerSubscription] ([CustomerSubscriptionID])

								ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID]

							
	IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionHistory_CustomerSubscription_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerSubscription]/[tescosubscription].[CustomerSubscriptionHistory] does not exist.',16,1)
	END
GO
