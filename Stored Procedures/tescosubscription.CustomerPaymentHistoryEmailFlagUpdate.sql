IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [subscription].[CustomerPaymentHistoryEmailFlagUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [subscription].[CustomerPaymentHistoryEmailFlagUpdate] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]
(
	--INPUT PARAMETERS HERE--
	@TransactionID as varchar(Max)
)
AS

/*

	Author:			Manjunathan Raman
	Date created:	26 Aug 2011
	Purpose:		To update Email flag
	Behaviour:		This procedure is called from Appstore on receiving response from notification service
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
*/

BEGIN
	DECLARE @CurrentDate DATETIME,
			@chrind INT,
		    @Piece BIGINT	
	SET NOCOUNT ON

	
	CREATE  TABLE #TempPaymentHistory(TransactionID BIGINT)
	 
	SELECT @chrind = 1, @CurrentDate=GETUTCDATE()
	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(',',@TransactionID)
		IF @chrind > 0
			SELECT @Piece = LEFT(@TransactionID,@chrind - 1)
		ELSE
			SELECT @Piece = @TransactionID
		INSERT #TempPaymentHistory(TransactionID) VALUES(@Piece)
		SELECT @TransactionID = RIGHT(@TransactionID,LEN(@TransactionID) - @chrind)
		IF LEN(@TransactionID) = 0 BREAK
	END

	UPDATE PayHist
		SET IsEmailSent=1,
			UTCUpdatedDateTime=@CurrentDate
	FROM
	 tescosubscription.CustomerPaymentHistory  PayHist
	JOIN #TempPaymentHistory TempTb
		ON TempTb.TransactionID=CustomerPaymentHistoryID
			
	DROP TABLE #TempPaymentHistory
			
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] not created.',16,1)
	END
GO
