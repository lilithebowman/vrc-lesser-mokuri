using System.IO;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif
#if VRC_SDK_VRCSDK3
using VRC.SDK3.Avatars.Components;
using VRC.SDK3.Avatars.ScriptableObjects;
#endif

namespace Hirabiki.AV3.Works.VRCLens
{
    public class VRCLensProfileManager
    {
#if UNITY_EDITOR
        public const int PROFILE_VERSION = 1;
        public int jsonProfileVersion;

        public int _setupMode = -1;
        public int _maxBlurIndex = -1, _sensorResIndex = -1, _tonemapIndex = -1;
        public int _afModeIndex = -1, _focalIndex = -1, _apertureIndex = -1, _sensorSizeIndex = -1;

        public string _targetSubMenu;
        public Vector2Int _customSensorRes;
        public Vector3 _cameraModelPosition, _cameraModelRotation, _cameraRotation, _focusPenRotation, _previewPosition;
        public float _cameraSize, _previewSize;
        public string _cameraModel;
        public bool _useWriteDefaults, _useDisableButton;
        public bool _av3Puppet, _av3Zoom, _av3Exposure, _av3Aperture, _av3Focus;
        public bool _animAE, _animDOF, _animGrid, _animLevel, _animDirectStream, _animLegacyStream;

        private VRCLensSetup p;
        public VRCLensProfileManager()
        {
            // Blank
        }
        public void SetContext(VRCLensSetup context)
        {
            p = context;
        }

        public bool SaveToJSONFile(string avatarFilename)
        {
            string unityPath = EditorUtility.SaveFilePanelInProject("Save VRCLens profile", avatarFilename + ".json", "JSON file", "Enter the name of the settings profile to be saved", p.UserPath);
            if(unityPath == "") return false;
            FetchProperties();
            jsonProfileVersion = PROFILE_VERSION; // Validation

            string json = JsonUtility.ToJson(this);
            File.WriteAllText(unityPath, json);

            return true;
        }
        public bool LoadFromJSONFile()
        {
            string uniyPath = EditorUtility.OpenFilePanelWithFilters("Load VRCLens profile", p.UserPath, new string[] { "JSON file", "json" });
            if(!File.Exists(uniyPath)) return false;
            //FetchProperties();

            string jsonString = File.ReadAllText(uniyPath);
            VRCLensProfileManager profileData = null;

            try
            {
                profileData = JsonUtility.FromJson<VRCLensProfileManager>(jsonString);
                if(profileData.jsonProfileVersion != PROFILE_VERSION)
                {
                    Debug.LogWarning("Loaded file is not a valid VRCLens profile.");
                    return false;
                }
            } catch(System.ArgumentException)
            {
                Debug.LogWarning("Loaded file is not a valid JSON.");
                return false;
            }

            profileData.SetContext(p);

            //profileData.inheritPropertiesIfNoValue(this);
            profileData.WriteProperties();

            Debug.Log("VRCLens JSON profile loaded.");
            return true;
        }
        public void inheritPropertiesIfNoValue(VRCLensProfileManager source)
        {
            // Might not be used...
            sd(ref _setupMode, ref source._setupMode);
            sd(ref _maxBlurIndex, ref source._maxBlurIndex);
            sd(ref _sensorResIndex, ref source._sensorResIndex);
            sd(ref _tonemapIndex, ref source._tonemapIndex);
            sd(ref _afModeIndex, ref source._afModeIndex);
            sd(ref _focalIndex, ref source._focalIndex);
            sd(ref _apertureIndex, ref source._apertureIndex);
            sd(ref _sensorSizeIndex, ref source._sensorSizeIndex);

            _targetSubMenu = _targetSubMenu == ""
                ? source._targetSubMenu : _targetSubMenu;

            _customSensorRes = _customSensorRes == new Vector2Int(0, 0)
                ? source._customSensorRes : _customSensorRes;

            _cameraModelPosition = new Vector3().Equals(_cameraModelPosition)
                ? source._cameraModelPosition : _cameraModelPosition;
            _cameraModelRotation = new Vector3().Equals(_cameraModelRotation)
                ? source._cameraModelRotation : _cameraModelRotation;

            _cameraRotation = new Vector3().Equals(_cameraRotation)
                ? source._cameraRotation : _cameraRotation;
            _focusPenRotation = new Vector3().Equals(_focusPenRotation)
                ? source._focusPenRotation : _focusPenRotation;
            _cameraSize = _cameraSize == 0f
                ? source._cameraSize : _cameraSize;
            _previewPosition = new Vector3().Equals(_previewPosition)
                ? source._previewPosition : _previewPosition;
            _previewSize = _previewSize == 0f
                ? source._previewSize : _previewSize;
            _cameraModel = _cameraModel == ""
                ? source._cameraModel : _cameraModel;

        }
        private void sd(ref int a, ref int b)
        {
            a = a == -1 ? b : a;
        }

        private bool FetchProperties()
        {
            _setupMode = (int)p.setupMode;
            _maxBlurIndex = p.maxBlurIndex;
            _sensorResIndex = p.sensorResIndex;
            _tonemapIndex = p.tonemapIndex;
            _afModeIndex = p.afModeIndex;
            _focalIndex = p.focalIndex;
            _apertureIndex = p.apertureIndex;
            _sensorSizeIndex = p.sensorSizeIndex;

            _targetSubMenu = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(p.targetSubMenu));

            _customSensorRes = p.customSensorRes;

            _cameraModelPosition = p.cameraModelPosition;
            _cameraModelRotation = p.cameraModelRotation;
            _cameraRotation = p.cameraRotation;
            _focusPenRotation = p.focusPenRotation;
            _cameraSize = p.cameraSize;
            _previewPosition = p.previewPosition;
            _previewSize = p.previewSize;
            _cameraModel = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(p.cameraModel));

            //_useWriteDefaults = p.useWriteDefaults;
            _useDisableButton = p.useDisableButton;

            _av3Puppet = p.av3Puppet;
            _av3Zoom = p.av3Zoom;
            _av3Exposure = p.av3Exposure;
            _av3Aperture = p.av3Aperture;
            _av3Focus = p.av3Focus;

            _animAE = p.animAE;
            _animDOF = p.animDoF;
            _animGrid = p.animGrid;
            _animLevel = p.animLevel;
            _animDirectStream = p.animDirectStream;
            _animLegacyStream = p.animLegacyStream;

            return true;
        }

        private bool WriteProperties()
        {
            p.setupMode = (SetupMode)_setupMode;
            p.maxBlurIndex = _maxBlurIndex;
            p.sensorResIndex = _sensorResIndex;
            p.tonemapIndex = _tonemapIndex;
            p.afModeIndex = _afModeIndex;
            p.focalIndex = _focalIndex;
            p.apertureIndex = _apertureIndex;
            p.sensorSizeIndex = _sensorSizeIndex;
            /*
            string ap0 = AssetDatabase.GUIDToAssetPath(_targetSubMenu);
            if(ap0 != "")
            {
                p.targetSubMenu = AssetDatabase.LoadAssetAtPath<VRCExpressionsMenu>(ap0);
            }
            */

            p.customSensorRes = _customSensorRes;

            p.cameraModelPosition = _cameraModelPosition;
            p.cameraModelRotation = _cameraModelRotation;
            //p.cameraRotation = _cameraRotation;
            //p.focusPenRotation = _focusPenRotation;
            p.cameraSize = _cameraSize;
            p.previewPosition = _previewPosition;
            p.previewSize = _previewSize;
            string ap1 = AssetDatabase.GUIDToAssetPath(_cameraModel);
            if(ap1 != "")
            {
                p.cameraModel = AssetDatabase.LoadAssetAtPath<GameObject>(ap1);
            }

            //p.useWriteDefaults = _useWriteDefaults;
            p.useDisableButton = _useDisableButton;

            p.av3Puppet = _av3Puppet;
            p.av3Zoom = _av3Zoom;
            p.av3Exposure = _av3Exposure;
            p.av3Aperture = _av3Aperture;
            p.av3Focus = _av3Focus;

            p.animAE = _animAE;
            p.animDoF = _animDOF;
            p.animGrid = _animGrid;
            p.animLevel = _animLevel;
            p.animDirectStream = _animDirectStream;
            p.animLegacyStream = _animLegacyStream;

            return true;
        }
#endif
    }
}