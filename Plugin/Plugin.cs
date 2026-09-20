using System.Reflection;
using BepInEx;
using BepInEx.Logging;
using HarmonyLib;
using UnityEngine.UI;

namespace UltraWidePlugin;

[BepInPlugin("in.jnotjay.plugin.ultrawide", MyPluginInfo.PLUGIN_NAME, MyPluginInfo.PLUGIN_VERSION)]
public class Plugin : BaseUnityPlugin
{
    internal static new ManualLogSource Logger;
    static readonly Resolution[] UltraWideResolutions = [
        new (2560, 1080),
        new (2560, 1600),
        new (3840, 1080),
        new (3440, 1440),
        new (3840, 1600),
    ];

    private void Awake()
    {
        Logger = base.Logger;
        Harmony.CreateAndPatchAll(typeof(Plugin), null);
        UpdateResolutionOptionsList();
    }

    private void UpdateResolutionOptionsList()
    {
        FieldInfo resolutionType = typeof(DataSaver).GetField(nameof(DataSaver.resolutionType), BindingFlags.Static | BindingFlags.Public);
        Resolution[] baseResolutions = (Resolution[])resolutionType.GetValue(null);
        Resolution[] newResolutions = [
            ..baseResolutions,
            ..UltraWideResolutions,
        ];
        resolutionType.SetValue(null, newResolutions);
    }

    [HarmonyPostfix]
    [HarmonyPatch(typeof(CanvasScaler), "OnEnable", MethodType.Normal)]
    public static void OnEnablePostfix(CanvasScaler __instance)
    {
        __instance.matchWidthOrHeight = 1.0f;
    }
}
