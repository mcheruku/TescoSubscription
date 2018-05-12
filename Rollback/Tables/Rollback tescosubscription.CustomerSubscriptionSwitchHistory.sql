/*

	Author:			Robin
	Date created:	16-Jan-2013
	Purpose:		Rollback Table [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table	.[CustomerSubscriptionSwitchHistory] does not exist.'
	END
GO
