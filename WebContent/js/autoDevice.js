function OpenDevice_OC() {
	return ocx.YKT_OpenDevice_OC();
}

function ReadCardType_OC() {
	return ocx.YKT_ReadCardType_OC();
}

function ReadBaozhangKH_OC() {
	return ocx.YKT_ReadBaozhangKH_OC();
}

function GetCardNo_OC(yqid){
	return ocx.YKT_GetCardNo_OC(yqid);
}
function ykt_readbzk() {
var yingquid = getyq();
	var cardno = ocx.YKT_ReadBZK_OC(yingquid);
	return cardno;
}

OpenDevice_OC();