// ============================================================================
// This is auto-generated by gf cli tool only once. Fill this file as you wish.
// ============================================================================

package dao

import (
	"gfast/app/system/dao/internal"
	"gfast/app/system/model"
	"github.com/gogf/gf/frame/g"
)

// sysLoginLogDao is the manager for logic model data accessing
// and custom defined data operations functions management. You can define
// methods on it to extend its functionality as you wish.
type sysLoginLogDao struct {
	internal.SysLoginLogDao
}

var (
	// SysLoginLog is globally public accessible object for table sys_login_log operations.
	SysLoginLog = sysLoginLogDao{
		internal.SysLoginLog,
	}
)

// Fill with you ideas below.

// SaveLog 保存日志信息
func (d sysLoginLogDao) SaveLog(data *model.SysLoginLog) {
	_, err := d.FieldsEx("info_id").Insert(data)
	if err != nil {
		g.Log().Error(err)
	}
}
