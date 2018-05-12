/*
	Created By:       Robin
	Date created:     13-Dec-2012
	Purpose:          Insert records to table [tescosubscription].[PaymentInstallment]
	Usage:            Data used for subscriptions 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On	    Changed By        Defect            Description
	 
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0
CREATE TABLE #InsertData
(
    [PaymentInstallmentID] [tinyint] NOT NULL,
	[PaymentInstallmentName] [varchar](100) NOT NULL,
	[InstallmentTenure] [tinyint] NULL
) ON [PRIMARY]


INSERT INTO #INSERTDATA(
	PaymentInstallmentID,
	PaymentInstallmentName,
	InstallmentTenure
	 )
SELECT 1,'Upfront Payment',NULL
UNION ALL
SELECT 2,'Monthly Payment',1
 
SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[PaymentInstallment] DestTable
ON  ToInsert.PaymentInstallmentID = DestTable.PaymentInstallmentID

INSERT INTO [tescosubscription].[PaymentInstallment](
	PaymentInstallmentID,
	PaymentInstallmentName,
	InstallmentTenure
	)
SELECT 
	ToInsert.PaymentInstallmentID,
	ToInsert.PaymentInstallmentName,
	ToInsert.InstallmentTenure
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[PaymentInstallment] DestTable
ON  ToInsert.PaymentInstallmentID = DestTable.PaymentInstallmentID
WHERE DestTable.PaymentInstallmentID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[PaymentInstallment].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[PaymentInstallment].'

DROP TABLE #INSERTDATA

GO
