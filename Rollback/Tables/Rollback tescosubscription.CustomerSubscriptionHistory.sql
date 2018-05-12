/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Table [tescosubscription].[CustomerSubscriptionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[CustomerSubscriptionHistory]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerSubscriptionHistory] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerSubscriptionHistory] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[CustomerSubscriptionHistory] does not exist.'
	END
GO
