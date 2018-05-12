/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[SubscriptionMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[SubscriptionMaster]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[SubscriptionMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[SubscriptionMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[SubscriptionMaster] does not exist.'
	END
GO
