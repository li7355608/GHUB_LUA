EnablePrimaryMouseButtonEvents(true)

-- 配置区域
local enable = false
local toggle_key = 8
local aim_key = 3
local action_key = "lctrl"

-- 随机延迟区间 (毫秒)
local min_delay = 68
local max_delay = 75

function OnEvent(event, arg)
    -- 全局开关
    if (event == "MOUSE_BUTTON_PRESSED" and arg == toggle_key) then
        enable = not enable

        if enable then
            OutputLogMessage(">>> 瞬狙脚本: 已开启 (ON)\n")
            -- 强制同步、开启时，如果灯没亮就亮；如果已经亮了就不动。
            if not IsKeyLockOn("capslock") then
                PressAndReleaseKey("capslock")
            end
        else
            OutputLogMessage("<<< 瞬狙脚本: 已关闭 (OFF)\n")
            -- 强制同步、关闭时，如果灯亮着就按灭它。
            if IsKeyLockOn("capslock") then
                PressAndReleaseKey("capslock")
            end
        end
    end

    -- 切换逻辑
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1) then
        -- 只有在【脚本开启】且【按住右键】时才触发
        if enable and IsMouseButtonPressed(aim_key) then
            local random_sleep = math.random(min_delay, max_delay)
            Sleep(random_sleep)
            PressAndReleaseKey(action_key)
            OutputLogMessage("触发瞬狙弦化，延迟: %d ms\n", random_sleep)
        end
    end
end