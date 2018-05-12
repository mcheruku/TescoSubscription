
/*

	Author:			Robin John
	Date created:	07-Jan-2012
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
     15 JAN 2013     Robin                          New table
	 17 Jan 2013     Robin                          Changed the data type to int  
*/



IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NULL
BEGIN

CREATE TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] (
	[CustomerSubscriptionID] [bigint] NOT NULL,
	[SwitchTo] [INT] NULL,
    [SwitchStatus] [Tinyint] NOT NULL,
    [SwitchOrigin] [Varchar] (200) NULL,
    [UTCRequestedDateTime] [datetime] NOT NULL CONSTRAINT [DF_CustomerSubscriptionSwitchHistory_UTCRequestedDateTime]  DEFAULT (getutcdate())
         )

 
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] already exists.'
	END
GO


