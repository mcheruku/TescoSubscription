/*
	Created By:       Robin
	Date created:     13-Dec-2012
	Purpose:          Rollback changes made to table [tescosubscription].[PaymentInstallment]
	Usage:            Data used for Click And Collect 
	Data Type:        Hybrid - Updated via DB script or application
    Warm Up Script    


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0
CREATE TABLE #InsertData
(
    [PaymentInstallmentID] [tinyint] NOT NULL,
	[PaymentInstallmentName] [varchar](100)  NOT NULL,
	[InstallmentTenure] [tinyint] NULL
) ON [PRIMARY]


INSERT INTO #InsertData
(
	PaymentInstallmentID,
	PaymentInstallmentName,
	InstallmentTenure 
       )

SELECT 1,'Upfront Payment',NULL
UNION ALL
SELECT 2,'Monthly Payment' ,1

SELECT @notExists = COUNT(1) 
FROM #InsertData ToInsert
LEFT JOIN [tescosubscription].[PaymentInstallment] DestTable
ON  ToInsert.PaymentInstallmentID = DestTable.PaymentInstallmentID
WHERE DestTable.PaymentInstallmentID Is Null


DELETE [tescosubscription].[PaymentInstallment]
FROM #InsertData ToInsert
JOIN [tescosubscription].[PaymentInstallment] DestTable
ON  ToInsert.PaymentInstallmentID = DestTable.PaymentInstallmentID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[PaymentInstallment].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[PaymentInstallment].'

DROP TABLE #InsertData

GO
