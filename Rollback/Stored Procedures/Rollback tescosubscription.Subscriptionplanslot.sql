/*

	Author:			ROBIN JOHN
	Date created:	05 Dec 2012
	Purpose:		Rollback Table [tescosubscription].[subscriptionplanslot]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[subscriptionplanslot]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[subscriptionplanslot]

		IF OBJECT_ID(N'[tescosubscription].[subscriptionplanslot]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[subscriptionplanslot] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[subscriptionplanslot] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[subscriptionplanslot] does not exist.'
	END
GO
