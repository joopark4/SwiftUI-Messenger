//
//  SmileMeCameraViewController.swift
//  ChatModuleMessengerAppApple
//

import UIKit
import AVFoundation
import Photos
import NextLevel
import SDWebImageWebPCoder

enum FlashType: Int {
    case flashOff
    case flashOn
    case flashAuto
}

enum TimerType: Int {
    case timerZero
    case timer3s
    case timer5s
    case timer10s
}

enum CollectionViewType: Int {
    case emoticon
    case filter
}

enum TakePhotoOrVideo: Int {
    case photo
    case video
}

enum FilterType: Int, CaseIterable {
    case none
    case sharp
    case mono
    case sepia
    case warm
    case cool
}

enum ErrorType: Int {
    case network
    case diskFreeSpace
}

protocol SmileMeCameraViewControllerDelegate: AnyObject {
//    func getGIFDataUrl(_ viewController: SmileMeCameraViewController, gifUrl: URL)
    func getGIFDataUrl(gifUrl: URL)
}

class SmileMeCameraViewController: UIViewController {

    // MARK: - Life Cycle
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var filterCloseBtn: UIButton!
    @IBOutlet weak var cameraChangeBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var basePreview: UIView!
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var filterview: UIImageView!
    @IBOutlet weak var stickerview: UIImageView!
    @IBOutlet weak var smilemePreview: UIImageView!

    @IBOutlet weak var frontFlashView: UIView!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var takePhotoOptionView: UIView!
//    @IBOutlet weak var takePhotoOptionViewImg: UIImageView!
    @IBOutlet weak var backTakePhotoBtn: UIButton!
    @IBOutlet weak var takePhotoSaveBtn: UIButton!

    @IBOutlet weak var saveInfoIMageview: UIImageView!
    @IBOutlet weak var saveInfoLabel: UILabel!
    @IBOutlet weak var takeInfoImageview: UIImageView!
    @IBOutlet weak var takeInfoLabel: UILabel!

    private let context = CIContext()
    private let gifRect = CGRect(x: 0, y: 0, width: 375, height: 375)

    // gif create datas
    private var cameraImgArray: [UIImage] = []
    private var stickerImgArray: [UIImage] = []
    private var gifImgArray: [UIImage] = []
    private var tempGifUrl: URL?
    private var captureTimer: Timer?

    private var repeats = true
    private var filterOnOff = true
    private var takeStilSmileme = false
    private var dumyImage: UIImage?
//    private var uploadRequestData: SmileMeFileUploadRequest?

    private var stickerList: [URL] = []
    private var thumbnailList: [URL] = []
    private let stickerNameList: [String] = [
        "러브샷", "선물은나야", "러브라이브", "사랑의응원", "좋아요폭탄",
        "새해해돋이", "새해도령", "새해아씨",
        "근하신년", "호랑이새해", "복덩이왔다", "나이배달",
        "레옹", "라옹", "꿀잼", "커피한잔", "경고",
        "칭찬도장", "어머머머", "축하합니다", "치얼스",
        "힘내요", "피곤하다", "아파요", "밥먹자", "쏜다",
        "우산챙겨요", "어지러워", "오고있나", "가고있어", "춥다", "더워",
        "ㄷㄷㄷ",
        "안녕", "미안", "좋아!", "뭐야", "ㅋㅋㅋ",
        "전화해", "답답해", "고마워", "화가 난다",
        "지켜본다", "축하해", "뭐해", "감동이야", "제발",
        "시무룩", "안돼", "파이팅", "사랑해", "잘자", "최고"
    ]

//    private let smilemeFolderName = EmoticonGroup.smileme.rawValue
    private var smilemeLocalBaseUrl: URL?

    private var videoProgress: TakeSmileMeProgressView?
    private var takeVidoePercent: Double = 0
    private var takeVideoTimer: Timer?

    private var currentFlashType: FlashType = .flashOff
    private var currentTimerType: TimerType = .timerZero
    private var currentCollectionViewType: CollectionViewType = .emoticon
    private var takePhotoOrVideo: TakePhotoOrVideo = .video
    private var selectedFilterType: FilterType = .none
    private var selectedStickerType: Int = 0
    private var currentBrightness: Double = 0

    // flash
    @IBOutlet weak var flashOffBtn: UIButton!
    @IBOutlet weak var flashOnBtn: UIButton!
    @IBOutlet weak var flashAutoBtn: UIButton!

    // take timer
    @IBOutlet weak var timerZeroBtn: UIButton!
    @IBOutlet weak var timer3sBtn: UIButton!
    @IBOutlet weak var timer5sBtn: UIButton!
    @IBOutlet weak var timer10sBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!

    private var timerSecond = 0
    private var timer: Timer?

    @IBOutlet weak var tapGestureBGForPopupView: UIView!
    @IBOutlet weak var infoPopupView: UIView! {
        didSet {
            infoPopupView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var flashPopupView: UIView! {
        didSet {
            flashPopupView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var timerPopupView: UIView! {
        didSet {
            timerPopupView.layer.cornerRadius = 8
        }
    }

    private var observer: NSObjectProtocol?

    // 작은화면 대응
    @IBOutlet weak var closeBtn_supportSE: UIButton!
    @IBOutlet weak var infoBtnTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeBaseView: UIView!
    @IBOutlet weak var takePhotoBtnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var takePhotoBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var takePhotoOptionViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var takePhotoOptionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var basePreviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraOptionViewHeightConstraint: NSLayoutConstraint!
    ////////////
//    @IBOutlet weak var cameraOptionViewBottomConstraint: NSLayoutConstraint!

    // 시나리오 변경으로 타이머, 플래시, 스틸컷 촬영 숨김
    let stilcutHidden = true

    // swfitui에서 사용될 delegate
    weak var smileMeCameraViewControllerDelegate: SmileMeCameraViewControllerDelegate?

    override func viewDidLoad() {
        setUp()
        setCollectionCell()
    }

    deinit {
        print(#function)
        clearAllData()
    }

    private func setUp() {

        if stilcutHidden {
            flashBtn.isHidden = true
            timerBtn.isHidden = true
        }

//        smilemeLocalBaseUrl = FileWorker.shared.getChatEmoticonCachePath(path: smilemeFolderName)
        preview.isHidden = true
        smilemePreview.isHidden = true
        frontFlashView.isHidden = true

        /** 카메라 관련 설정 */
        let nextlevel = NextLevel.shared

        nextlevel.videoDelegate = self
        nextlevel.deviceDelegate = self

        /** PreView */
        preview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        preview.backgroundColor = .black
        nextlevel.previewLayer.frame = preview.bounds
        preview.layer.addSublayer(NextLevel.shared.previewLayer)

        /** Video Configuration */
        nextlevel.videoConfiguration.preset = AVCaptureSession.Preset.hd1280x720
        nextlevel.videoConfiguration.bitRate = 1000000
        nextlevel.videoConfiguration.maxKeyFrameInterval = 24
        nextlevel.videoConfiguration.profileLevel = AVVideoProfileLevelH264HighAutoLevel
        nextlevel.isVideoCustomContextRenderingEnabled = true

        /** Device Configuration */
        nextlevel.devicePosition = .front

        nextlevel.captureMode = .videoWithoutAudio

        filterview.contentMode = .scaleAspectFill
        stickerview.contentMode = .scaleToFill
        /***************************/

        let pinchGestureReconizer = UIPinchGestureRecognizer(target: self, action: #selector(setCameraZoomScale(_:)))
        basePreview.addGestureRecognizer(pinchGestureReconizer)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopupView))
        // 툴팁 떠있을경우에 pinch 줌도 툴팁 사라지도록
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.dismissPopupView))
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissPopupView))
        swipeGestureRight.direction = .right
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissPopupView))
        swipeGestureLeft.direction = .left

        tapGestureBGForPopupView.isUserInteractionEnabled = true
        tapGestureBGForPopupView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureBGForPopupView.addGestureRecognizer(pinchGesture)
        tapGestureBGForPopupView.addGestureRecognizer(swipeGestureRight)
        tapGestureBGForPopupView.addGestureRecognizer(swipeGestureLeft)

        isHiddenSaveInfoViews(status: true)

        screenSizeCheck()

        stickerList = getStickerList()
        thumbnailList = getThumbnailList()
        loadStickerWebp(index: selectedStickerType)
        
        let takeProgressView = TakeSmileMeProgressView(frame: CGRect(x: 0, y: 0, width: 68, height: 68))
        takePhotoBtn.addSubview(takeProgressView)
        self.videoProgress = takeProgressView
        
        let saveProgressView = TakeSmileMeProgressView(frame: CGRect(x: 0, y: 0, width: 68, height: 68))
        saveProgressView.updatePercent(progress: 100)
        takePhotoOptionView.addSubview(saveProgressView)

        observer = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in

            if self?.takeVidoePercent ?? 0 > 0 && self?.takeVidoePercent ?? 0 < 100 {
                self?.takeSmileMeCancel()
            }
        }
    }

    private func setCollectionCell() {
        let emoticonCell = UINib(nibName: "SmileMeEmoticonCollectionViewCell", bundle: nil)
        collectionView.register(emoticonCell, forCellWithReuseIdentifier: "SmileMeEmoticonCollectionViewCell")
    }

    @objc func dismissPopupView() {
        if !infoPopupView.isHidden {
            infoPopupView.isHidden = true
        } else if !flashPopupView.isHidden {
            flashPopupView.isHidden = true
        } else if !timerPopupView.isHidden {
            timerPopupView.isHidden = true
        }

//        UserDefaultsHelper.standard.setValue(true, forKey: UserDefaultsKey.smileMeTakeInfo.rawValue)

        tapGestureBGForPopupView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cameraStart()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        cameraStop()
    }

    @objc func longPress(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            startTakeProgress()
        } else if gesture.state == .ended {
            endTakeProgress()
        }
    }

    @IBAction func clickClose(_ sender: Any) {

    }

    @IBAction func clickTakePhoto(_ sender: Any) {
        isHiddenTakeInfoViews(status: true)

        startTakeProgress()

        if stilcutHidden {
            return
        }

        if self.currentTimerType != .timerZero {

            if takePhotoOptionView.isHidden {
                self.startTimer()
            }
        } else {
            takePhoto()
        }
    }

    @IBAction func clickFilterMode(_ sender: Any) {
        filterBtn.isHidden = true
        filterCloseBtn.isHidden = false
        currentCollectionViewType = .filter

        collectionView.reloadData()
    }

    @IBAction func clickFilterCloseMode(_ sender: Any) {
        filterBtn.isHidden = false
        filterCloseBtn.isHidden = true
        currentCollectionViewType = .emoticon

        collectionView.reloadData()
    }

    @IBAction func clickInfoBtn(_ sender: Any) {
        tapGestureBGForPopupView.isHidden = false
        infoPopupView.isHidden = false
    }

    @objc private func didTappedOutside(_ sender: UITapGestureRecognizer) {
            self.dismiss(animated: true, completion: nil)
    }

    // flash 선택
    @IBAction func clickFlashBtn(_ sender: Any) {
        tapGestureBGForPopupView.isHidden = false
        flashPopupView.isHidden = false
    }

    @IBAction func onClickFlashOff(_ sender: Any) {
        setFlashOption(type: .flashOff)
    }

    @IBAction func oncClickFlashOn(_ sender: Any) {
        setFlashOption(type: .flashOn)
    }

    @IBAction func onClickFlashAuto(_ sender: Any) {
        setFlashOption(type: .flashAuto)
    }

    // timer 선택
    @IBAction func clickTimerBtn(_ sender: Any) {
        tapGestureBGForPopupView.isHidden = false
        timerPopupView.isHidden = false
    }

    @IBAction func onClickTimerZero(_ sender: Any) {
        setTimerOption(type: .timerZero)
    }

    @IBAction func onClickTimer3s(_ sender: Any) {
        setTimerOption(type: .timer3s)
    }

    @IBAction func onClickTimer5s(_ sender: Any) {
        setTimerOption(type: .timer5s)
    }

    @IBAction func onClickTimer10s(_ sender: Any) {
        setTimerOption(type: .timer10s)
    }

    // timer cancel or save 동작
    @IBAction func clickOptionViewBtn(_ sender: Any) {

        if !takePhotoOptionView.isHidden {
            if timer != nil {
                takeStilSmileme = false
                stopTimer()
                return // 타이머 취소인 경우 버튼만 초기화
            }

            if takeStilSmileme {
                createSmileMeStilImage()
            } else {
                createSmileMe()
            }

            // 저장 후에 스티커, 필터 초기화
            self.selectedFilterType = .none
            self.selectedStickerType = 0

            if currentCollectionViewType == .filter {
                self.filterCloseBtn.isHidden = true
                self.currentCollectionViewType = .emoticon
            }

            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)

            self.collectionView.reloadData()

            takePhotoSaveBtn.isEnabled = false // 네트워크가 느릴때 스마일미 업로드 사이 전송버튼 여러번 터치 할 수 있어 터치 막음
            isHiddenSaveInfoViews(status: true)
            changeSmilemeSaveStatus(status: true)
            
            guard let url = tempGifUrl else { return }
            print("smv : \(url.path)")
            self.smileMeCameraViewControllerDelegate?.getGIFDataUrl(gifUrl: url)
        }
    }

    @IBAction func clickBackTakePhotoBtn(_ sender: Any) {
        isHiddenTakeInfoViews(status: false)
        takePhotoBtn.setImage(UIImage(systemName: "hand.tap.fill"), for: .normal)
        takePhotoBtn.setPreferredSymbolConfiguration(.init(font: .systemFont(ofSize: 31)), forImageIn: .normal)
        takePhotoOptionView.isHidden = true
        videoProgress?.isHidden = false
        videoProgress?.updatePercent(progress: 0)
        backTakePhotoBtn.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        backTakePhotoBtn.isHidden = true
        smilemePreview.isHidden = true
        takePhotoSaveBtn.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        takePhotoSaveBtn.isEnabled = true
        displayTimer()
        updateTakePhotoButtons(isTake: false)
        
        if currentTimerType != .timerZero {
            timerLabel.isHidden = false
        } else {
            timerLabel.isHidden = true
        }
        
        takeStilSmileme = false

        clearGifTempData()
        loadStickerWebp(index: selectedStickerType)
    }

    @IBAction func selectedCameraChangeButton(_ sender: Any) {
        self.takePhotoBtn.isEnabled = false
        NextLevel.shared.flipCaptureDevicePosition()
    }

    private func takeSmileMeCancel() {
        self.backTakePhotoBtn.sendActions(for: .touchUpInside)
    }
}

// MARK: - Data Clear or Remove
extension SmileMeCameraViewController {
    private func removeUploadData() {

    }

    private func removeAllArray() {
        stickerImgArray.removeAll()
        cameraImgArray.removeAll()
        gifImgArray.removeAll()
    }

    private func clearImageView() {
        stickerview.image = nil
        filterview.image = nil
        dumyImage = nil
        preview.layer.removeFromSuperlayer()
    }

    private func stopTimer() {
        captureTimer?.invalidate()
        captureTimer = nil
        timer?.invalidate()
        timer = nil
        takeVideoTimer?.invalidate()
        takeVideoTimer = nil
    }

    private func clearGifTempData() {
        removeUploadData()
        removeAllArray()
        stopTimer()
        deleteTempGifFiles()
        isHiddenSaveInfoViews(status: true)
    }

    private func clearAllData() {
        stopTimer()
        removeAllArray()
        stickerList.removeAll()
        thumbnailList.removeAll()
        clearImageView()
        removeUploadData()
        tempGifUrl = nil
        clearGifTempData()
        self.observer = nil
    }
}

// MARK: - Change Status
extension SmileMeCameraViewController {
    // 동영상및 타이머 찍는동안 버튼 ui 보이기 / 안보이기
    private func updateTakePhotoButtons(isTake: Bool) {
        if isTake {
            flashBtn.isHidden = true
            timerBtn.isHidden = true
            filterBtn.isHidden = true
            filterCloseBtn.isHidden = true
            cameraChangeBtn.isHidden = true
            collectionView.isHidden = true
        } else {
            if stilcutHidden {
                flashBtn.isHidden = true
                timerBtn.isHidden = true
            } else {
                flashBtn.isHidden = false
                timerBtn.isHidden = false
            }

            if currentCollectionViewType == .filter {
                filterCloseBtn.isHidden = false
                filterBtn.isHidden = true
            } else {
                filterCloseBtn.isHidden = true
                filterBtn.isHidden = false
            }

            cameraChangeBtn.isHidden = false
            collectionView.isHidden = false
        }
    }

    private func isFilterOn() -> Bool {
        if self.selectedFilterType == .none {
            return false
        } else {
            return true
        }
    }

    private func changeSmilemeSaveStatus(status: Bool) {
        if status {
            takePhotoSaveBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
            takePhotoSaveBtn.isEnabled = false
            backTakePhotoBtn.setImage(UIImage(systemName: "repeat"), for: .normal)
//            ChatModuleToast(vc: self, message: "SmileMe.SaveSuccess".localized)
        }
    }

    private func changeTorchMode(on: Bool) {
        if on {
            NextLevel.shared.torchMode = .on
        } else {
            NextLevel.shared.torchMode = .off
        }
    }

    private func isHiddenSaveInfoViews(status: Bool) {
        saveInfoIMageview.isHidden = status
        saveInfoLabel.isHidden = status
    }

    private func isHiddenTakeInfoViews(status: Bool) {
        takeInfoImageview.isHidden = status
        takeInfoLabel.isHidden = status
    }

    func screenSizeCheck() {
        let screenBounds = UIScreen.main.bounds
        let screen_height = screenBounds.height

        switch screen_height {
        case 926:
            print("iPhone 12 pro Max")
//            cameraOptionViewBottomConstraint.constant = -95
        case 896:
            print("iPhone 11, 11 pro Max, XR, XS Max")
//            cameraOptionViewBottomConstraint.constant = -85
        case 847:
            print("iPhone 7 plus, 6s plus, 6 plus")
        case 844:
            print("iPhone 12, 12 pro")
//            cameraOptionViewBottomConstraint.constant = -55
        case 812:
            print("iPhone 12 mini, 11 pro, XS, X")
        case 736:
            print("iPhone 8 plus")
        case 667:
            print("iPhone SE 2nd, 8, 7, 6s, 6")
            supportDeviceSE()
        default:
            print("iPhone SE, etc...")
            supportDeviceSE()
        }
    }

    func supportDeviceSE() {
        closeBaseView.isHidden = true
        closeBtn_supportSE.isHidden = false
        infoBtnTrailingConstraint.constant = 64
        optionViewTopConstraint.constant = -44

        let takePhotoViewSize = CGFloat(60.0)
        takePhotoBtnWidthConstraint.constant = takePhotoViewSize
        takePhotoBtnHeightConstraint.constant = takePhotoViewSize
        takePhotoOptionViewWidthConstraint.constant = takePhotoViewSize
        takePhotoOptionViewHeightConstraint.constant = takePhotoViewSize
        basePreviewTopConstraint.constant = 0
        cameraOptionViewHeightConstraint.constant = 100
    }
}

// MARK: - Create SmileMe
extension SmileMeCameraViewController {
    private func startTakeProgress() {
        if currentTimerType != .timerZero {
            timerLabel.isHidden = true
        }

        self.updateTakePhotoButtons(isTake: true)

        takeVidoePercent = 0
        self.videoProgress?.updatePercent(progress: 0)
        self.takePhotoBtn.setImage(nil, for: .normal)
        self.takeVideoTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] tiemr in
            self?.takeVidoePercent += 5
            self?.videoProgress?.updatePercent(progress: self?.takeVidoePercent ?? 0)

            if self?.takeVidoePercent == 100 {
                tiemr.invalidate()
                self?.updateTakePhotoButtons(isTake: true)
            }
        })

        #if targetEnvironment(simulator)
        #else
        startCapture()
        #endif
    }

    private func endTakeProgress() {
        guard videoProgress?.isHidden == false else { return }

        stopTimer()

        updateTakePhotoButtons(isTake: true)
        takePhotoBtn.setImage(nil, for: .normal)
        takePhotoOptionView.isHidden = false
        backTakePhotoBtn.isHidden = false
//        videoProgress?.stopIcon.isHidden = true
        videoProgress?.isHidden = true
        takePhotoSaveBtn.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        repeats = false

        #if targetEnvironment(simulator)
        #else
        compositeSmileMe()
        #endif
    }

    private func createSmileMe() {
        guard let gifData = getUrlData(url: tempGifUrl) else {
            print(#function)
            return
        }

        guard let thum = getSmileMeThumbnail() else {
            print(#function)
            return
        }

        guard let thumData = thum.jpegData(compressionQuality: 0.7) else {
            print(#function)
            return
        }

//        ChatModuleProgress.show()

        var datas: [Data] = []
        datas.append(gifData)
        datas.append(thumData)

        removeUploadData()
        stopTimer()
    }

    private func createSmileMeStilImage() {
        guard let thumb = getSmileMeThumbnail() else {
            print(#function)
            return
        }

        guard let thumbData = thumb.jpegData(compressionQuality: 0.7) else {
            print(#function)
            return
        }

        let stilImg = gifImgArray[0]
        guard let stilData = stilImg.jpegData(compressionQuality: 1.0) else {
            print(#function)
            return
        }

        var datas: [Data] = []
        datas.append(stilData)
        datas.append(thumbData)

        removeUploadData()
        stopTimer()

    }

    private func startCapture() {
        guard captureTimer == nil else {
            return
        }

        self.loadStickerWebp(index: selectedStickerType)

        repeats = true
        captureTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(capturePhoto), userInfo: nil, repeats: self.repeats)
        self.capturePhoto()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.capturePhoto()
            self.endTakeProgress()
        }
    }

    @objc private func capturePhoto() {
        if self.repeats {
            renderFilterViewAsImage()
            renderStickerViewAsImage()
        }
    }

    private func takePhoto() {
        takeStilSmileme = true
        updateTakePhotoButtons(isTake: true)
        takePhotoOptionView.isHidden = false
        backTakePhotoBtn.isHidden = false
        takePhotoSaveBtn.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)

        #if targetEnvironment(simulator)
        #else
        if currentFlashType == .flashOn {
            startPhotoShootAndFlash()
        } else if currentFlashType == .flashAuto {
            if currentBrightness < 0 {
                startPhotoShootAndFlash()
            } else {
                startPhotoShoot()
            }
        } else {
            startPhotoShoot()
        }
        #endif
    }

    private func startPhotoShoot() {
        takeStilImage()
        previewStilImage()
        isHiddenSaveInfoViews(status: false)
    }

    private func startPhotoShootAndFlash() {
        if NextLevel.shared.devicePosition == .back {
            changeTorchMode(on: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.takeStilImage()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.changeTorchMode(on: false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.changeTorchMode(on: true)
                self.previewStilImage()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.changeTorchMode(on: false)
            }
        } else {
            let brightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
            frontFlashView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.takeStilImage()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.previewStilImage()
                UIScreen.main.brightness = brightness
                self.frontFlashView.isHidden = true
            }
        }
    }

    private func takeStilImage() {
        renderFilterViewAsImage()
        renderStickerViewAsImage()

        guard let stilImg = composite(image: cameraImgArray[0], overlay: stickerImgArray[0]) else {
            print("compositeImg fail")
            return
        }

        gifImgArray.append(stilImg)
    }

    private func previewStilImage() {
        smilemePreview.isHidden = false
    }

    private func createErrorAlert(type: ErrorType) {
        // 저장 버튼 터치 활성화
        takePhotoSaveBtn.isEnabled = true
    }

    private func smilemeFullItemAlert() {
    
    }
}

// MARK: - Filter or Sticker collection View
extension SmileMeCameraViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if self.currentCollectionViewType == .filter {
            return FilterType.allCases.count
        } else {
            return stickerList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SmileMeEmoticonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmileMeEmoticonCollectionViewCell", for: indexPath) as? SmileMeEmoticonCollectionViewCell else { return UICollectionViewCell()}
        cell.layer.cornerRadius = 6

        let row = indexPath.row

        if currentCollectionViewType == .filter {
            if selectedFilterType.rawValue == row {
                cell.setSelected(isSelect: true)
            } else {
                cell.setSelected(isSelect: false)
            }

            cell.setConfigFilterThumb(index: row)

        } else {

            if selectedStickerType == row {
                cell.setSelected(isSelect: true)
            } else {
                cell.setSelected(isSelect: false)
            }

            if self.stickerNameList.count > row && self.thumbnailList.count > row {
                cell.setConfigStickerThumb(name: self.stickerNameList[row],
                                           imageUrl: self.thumbnailList[row])
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentCollectionViewType == .filter {
            selectedFilterType = FilterType(rawValue: indexPath.row) ?? .none
        } else {
            selectedStickerType = indexPath.row
            loadStickerWebp(index: selectedStickerType)
        }

        self.collectionView.reloadData()
    }

    // scrollDirection이 horizontal이면 Line으로 간격 조정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

// MARK: - File System
extension SmileMeCameraViewController {

    @discardableResult private func saveSmileFile(data: Data, name: String) -> Bool {
        if !freeSpaceCheck() {
            createErrorAlert(type: .diskFreeSpace)
        }

        do {
            if let url = smilemeLocalBaseUrl?.appendingPathComponent(name) {
                try data.write(to: url)
            }
        } catch {
            print("fail jpg write")
            createErrorAlert(type: .diskFreeSpace)
            return false
        }

        return true
    }

    private func getStickerList() -> [URL] {
        var list = [URL]()
        // 폴더명 내림차순으로 정렬 ex) ["4", "3", "2", "1"]
        let directories = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "SmileMeSticker/webp")?
            .compactMap { $0.relativePath }
            .sorted(by: >)

        // 폴더 순회하며 내부 컨텐츠 오름차순 정렬 ["001.webp", "002.webp", "003.webp"]
        directories?.forEach {
            if let items = Bundle.main.urls(forResourcesWithExtension: "webp", subdirectory: "SmileMeSticker/webp/\($0)")?
                .sorted(by: {$0.absoluteString < $1.absoluteString}) {
                list.append(contentsOf: items)
            }
        }

        return list
    }

    private func getThumbnailList() -> [URL] {
        var list = [URL]()
        // 폴더명 내림차순으로 정렬 ex) ["4", "3", "2", "1"]
        let directories = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "SmileMeSticker/thumb")?
            .compactMap { $0.relativePath }
            .sorted(by: >)

        // 폴더 순회하며 내부 컨텐츠 오름차순 정렬 ["001_thumb.png", "002_thumb.png", "003_thumb.png"]
        directories?.forEach {
            if let items = Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: "SmileMeSticker/thumb/\($0)")?
                .sorted(by: {$0.absoluteString < $1.absoluteString}) {
                list.append(contentsOf: items)
            }
        }

        return list
    }

    private func getUrlData(url: URL?) -> Data? {
        guard let url = url else {
            return nil
        }

        var data: Data?

        do {
             data = try Data(contentsOf: url)
        } catch {
            print("fail url to data")
        }

        return data
    }

    private func getFileSize(for key: FileAttributeKey) -> Int64? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

        guard
            let lastPath = paths.last,
            let attributeDictionary = try? FileManager.default.attributesOfFileSystem(forPath: lastPath) else { return nil }

        if let size = attributeDictionary[key] as? NSNumber {
            return size.int64Value
        } else {
            return nil
        }
    }

    private func convert(_ bytes: Int64, to units: ByteCountFormatter.Units = .useMB) -> String? {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = units
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes)
    }

    private func freeSpaceCheck() -> Bool {
        let freeSpaceInt64 = getFileSize(for: .systemFreeSize)
        let convertInt = Int(truncatingIfNeeded: freeSpaceInt64 ?? 100)
        let limitFreeSpace = 10485760 // 10mb
        return convertInt > limitFreeSpace ? true : false
    }

    private func deleteTempGifFiles() {
        let tempDir = NSTemporaryDirectory()
        let gifString = "NL.gif"
        let flist = FileManager.default.enumerator(atPath: tempDir)

        while let file = flist?.nextObject() {
            if let name = file as? String {
                if name.contains(gifString) {
                    let path = tempDir.appending(name)

                    do {
                        try FileManager.default.removeItem(atPath: path)
                    } catch {
                        print("error : \(error)")
                    }
                }
            }
        }
    }
}

// MARK: - Image Rnender
extension SmileMeCameraViewController {

    private func loadStickerWebp(index: Int) {
        let webpCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webpCoder)

        stickerview.sd_setImage(with: nil)
        stickerview.sd_setImage(with: stickerList[index])
    }

    private func getFilterType() -> String {
        switch self.selectedFilterType {
        case .mono:
            return "CIPhotoEffectMono"
        case .sharp:
            return "CISharpenLuminance"
        case .sepia:
            return "CISepiaTone"
        case .warm,
             .cool:
            return "CITemperatureAndTint"
        case .none:
            return ""
        }
    }

    // View image capture
    @objc private func renderStickerViewAsImage() {
        guard let image = stickerview.screenshot() else {
                return
        }

        guard let resize = resizeImage(image: image, targetSize: CGSize(width: gifRect.width, height: gifRect.height)) else {
            return
        }

        stickerImgArray.append(resize)
    }

    @objc private func renderFilterViewAsImage() {

        guard let image = filterview.screenshot() else {
            return
        }

        guard let resize = resizeImage(image: image, targetSize: CGSize(width: gifRect.width, height: gifRect.height)) else {
            return
        }

        cameraImgArray.append(resize)
    }

    // 이미지 겹치기
    private func composite(image: UIImage, overlay: (UIImage), scaleOverlay: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContext(image.size)
        var rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        image.draw(in: rect)
        if scaleOverlay == false {
            rect = CGRect(x: 0, y: 0, width: overlay.size.width, height: overlay.size.height)
        }
        overlay.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    private func compositeSmileMe() {
        let cnt = cameraImgArray.count < stickerImgArray.count ? cameraImgArray.count : stickerImgArray.count
        print(">>>>>>>>> cnt \(cnt)")

        for c in 0..<cnt {
            guard let compositeImg = composite(image: cameraImgArray[c], overlay: stickerImgArray[c]) else {
                print("compositeImg fail")
                return
            }

            gifImgArray.append(compositeImg)
        }

        NextLevelGIFCreator.init().create(gifWithImages: gifImgArray, delay: 0.2, loopCount: 0) { [weak self] _, url in
            self?.smilemePreview.sd_setImage(with: url)

            self?.smilemePreview.isHidden = false
            self?.tempGifUrl = url

            self?.isHiddenSaveInfoViews(status: false)
        }
    }

    private func getSmileMeThumbnail() -> UIImage? {
        guard gifImgArray.count != 0 else {
            print(#function)
            return nil
        }

        let thumImg = gifImgArray[gifImgArray.count-1]
        guard let thum = resizeImage(image: thumImg, targetSize: CGSize(width: 83, height: 83)) else {
            print(#function)
            return nil
        }

        return thum
    }

    // 이미지 리사이즈
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    // UIImage > CVPixelBuffer
    private func cvBuffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard status == kCVReturnSuccess else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData,
                                width: Int(image.size.width),
                                height: Int(image.size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }

    private func getBrightness(sampleBuffer: CMSampleBuffer) -> Double {
        let rawMetadata = CMCopyDictionaryOfAttachments(allocator: nil, target: sampleBuffer, attachmentMode: CMAttachmentMode(kCMAttachmentMode_ShouldPropagate))
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, rawMetadata) as NSMutableDictionary
        let exifData = metadata.value(forKey: "{Exif}") as? NSMutableDictionary
        let brightnessValue: Double = exifData?[kCGImagePropertyExifBrightnessValue as String] as! Double
        return brightnessValue
    }
}

// MARK: - Flash
extension SmileMeCameraViewController {
    private func setFlashOption(type: FlashType) {
        currentFlashType = type
        switch type {
            case .flashOff:
                flashBtn.setImage(UIImage(named: "icon24FlashOff"), for: .normal)
                flashOffBtn.tintColor = .white

            case .flashOn:
                flashBtn.setImage(UIImage(named: "icon24FlashOn"), for: .normal)
                flashOnBtn.tintColor = .white

            case .flashAuto:
                flashBtn.setImage(UIImage(named: "icon24FlashAuto"), for: .normal)
                flashAutoBtn.tintColor = .white
        }

        self.dismissPopupView()
    }

    private func setFlashMode(type: FlashType) {
        switch type {
        case .flashAuto:
            NextLevel.shared.flashMode = .auto

        case .flashOn:
            NextLevel.shared.flashMode = .on

        case .flashOff:
            NextLevel.shared.flashMode = .off
        }
    }
}

// MARK: - Timer
extension SmileMeCameraViewController {
    @objc func executeTimer() {
        timerSecond -= 1
        if timerSecond != 0 {
            timerLabel.text = String(timerSecond)
        } else {
            timer?.invalidate()
            timerLabel.isHidden = true
            timer = nil

            takePhoto()
        }
    }

    private func setTimerOption(type: TimerType) {
        currentTimerType = type

        switch type {
            case .timerZero:
                timerLabel.isHidden = true
                timerBtn.setImage(UIImage(named: "icon24CameraTimerOff"), for: .normal)
                timerZeroBtn.tintColor = .white
                break
            case .timer3s:
                timerLabel.isHidden = false
                timerBtn.setImage(UIImage(named: "icon24CameraTimer3S"), for: .normal)
                timer3sBtn.tintColor = .white
                break
            case .timer5s:
                timerLabel.isHidden = false
                timerBtn.setImage(UIImage(named: "icon24CameraTimer5S"), for: .normal)
                timer5sBtn.tintColor = .white
                break
            case .timer10s:
                timerLabel.isHidden = false
                timerBtn.setImage(UIImage(named: "icon24CameraTimer10S"), for: .normal)
                timer10sBtn.tintColor = .white
                break
        }

        displayTimer()
        self.dismissPopupView()
    }

    private func displayTimer() {
        switch currentTimerType {
        case .timer3s:
            timerSecond = 3
            break
        case .timer5s:
            timerSecond = 5
            break
        case .timer10s:
            timerSecond = 10
            break
        case .timerZero:
            return
        }
        timerLabel.text = String(timerSecond)
    }

    private func startTimer() {
        takePhotoOptionView.isHidden = false
        takePhotoSaveBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        updateTakePhotoButtons(isTake: true)

        if timerLabel.isHidden {
            timerLabel.isHidden = false
            displayTimer()
        }

        if !takePhotoOptionView.isHidden {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(1),
                                         target: self,
                                         selector: #selector(executeTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
}

// MARK: - Camera
extension SmileMeCameraViewController {

    private func cameraStart() {
        if NextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized {
            do {
                try NextLevel.shared.start()
            } catch {
                print("failed to start camera session")
            }
        } else {
            NextLevel.requestAuthorization(forMediaType: AVMediaType.video) { (mediaType, status) in
                print("authorization updated for media \(mediaType) status \(status)")
                if NextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized &&
                    NextLevel.authorizationStatus(forMediaType: AVMediaType.audio) == .authorized {
                    do {
                        try NextLevel.shared.start()
                    } catch {
                        print("failed to start camera session")
                    }
                } else if status == .notAuthorized {
                    // gracefully handle when audio/video is not authorized
                    print("doesn't have authorization for audio or video")
                }
            }
        }
    }

    private func cameraStop() {
        NextLevel.shared.stop()
    }

    @objc private func setCameraZoomScale(_ gestureRecognizer: UIPinchGestureRecognizer) {

        if gestureRecognizer.state  == .changed {
            let zoomFactor = NextLevel.shared.videoZoomFactor

            if gestureRecognizer.scale > 1 {
                let zoomIn = zoomFactor + 0.1
                NextLevel.shared.videoZoomFactor = zoomIn > 2 ? 2 : zoomIn
            } else {
                let zoomOut = zoomFactor - 0.1
                NextLevel.shared.videoZoomFactor = zoomOut < 1 ? 1 : zoomOut
            }
        }
    }
}

// MARK: - NextLevelVideoDelegate
extension SmileMeCameraViewController: NextLevelVideoDelegate {
    func nextLevel(_ nextLevel: NextLevel, didUpdateVideoZoomFactor videoZoomFactor: Float) {

        print(videoZoomFactor)
    }

    func nextLevel(_ nextLevel: NextLevel, willProcessRawVideoSampleBuffer sampleBuffer: CMSampleBuffer, onQueue queue: DispatchQueue) {

        let filteredImage: UIImage!

        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)

        guard let pixelBuffer = pixelBuffer else {
            return
        }

        var cameraImage: CIImage
        if nextLevel.devicePosition == .back {
            cameraImage = CIImage(cvImageBuffer: pixelBuffer)
        } else {
            // 좌우가 뒤집어져 전달되기 때문에 이미지 만들때 뒤집어 준다
            cameraImage = CIImage(cvImageBuffer: pixelBuffer).oriented(.upMirrored)
        }

        if isFilterOn() {
            let filterName = getFilterType()
            guard var effect = CIFilter(name: filterName) else { return }
            effect.setValue(cameraImage, forKey: kCIInputImageKey)
            if self.selectedFilterType == .sharp {
                let optionalBrightFilter = CIFilter(name: "CIColorControls")
                guard let brightFilter = optionalBrightFilter else { return }
                brightFilter.setValue(effect.outputImage, forKey: kCIInputImageKey)
                brightFilter.setValue(1.1, forKey: kCIInputContrastKey)

                effect = brightFilter
            } else if self.selectedFilterType == .warm {
                effect.setValue(CIVector(x: 6500, y: 80), forKey: "inputNeutral")
                effect.setValue(CIVector(x: 4500, y: 80), forKey: "inputTargetNeutral")
            } else if self.selectedFilterType == .cool {
                effect.setValue(CIVector(x: 6500, y: 250), forKey: "inputNeutral")
                effect.setValue(CIVector(x: 8800, y: 300), forKey: "inputTargetNeutral")
            }

            let cgImage = self.context.createCGImage(effect.outputImage!, from: cameraImage.extent)
            filteredImage = UIImage(cgImage: cgImage!)
        } else {
            filteredImage = UIImage(ciImage: cameraImage)
        }

        currentBrightness = getBrightness(sampleBuffer: sampleBuffer)

        self.dumyImage = nil
        self.dumyImage = filteredImage

        DispatchQueue.main.async {
            self.filterview.image = nil
            self.filterview.image = filteredImage
        }
    }

    func nextLevel(_ nextLevel: NextLevel, renderToCustomContextWithImageBuffer imageBuffer: CVPixelBuffer, onQueue queue: DispatchQueue) {
        guard let image = self.dumyImage else {
            return
        }

        if let frame = self.cvBuffer(from: image) {
            nextLevel.videoCustomContextImageBuffer = frame
        }
    }

    func nextLevel(_ nextLevel: NextLevel, willProcessFrame frame: AnyObject, timestamp: TimeInterval, onQueue queue: DispatchQueue) {

    }

    func nextLevel(_ nextLevel: NextLevel, didSetupVideoInSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didSetupAudioInSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didStartClipInSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didCompleteClip clip: NextLevelClip, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didAppendVideoSampleBuffer sampleBuffer: CMSampleBuffer, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didSkipVideoSampleBuffer sampleBuffer: CMSampleBuffer, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didAppendVideoPixelBuffer pixelBuffer: CVPixelBuffer, timestamp: TimeInterval, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didSkipVideoPixelBuffer pixelBuffer: CVPixelBuffer, timestamp: TimeInterval, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didAppendAudioSampleBuffer sampleBuffer: CMSampleBuffer, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didSkipAudioSampleBuffer sampleBuffer: CMSampleBuffer, inSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didCompleteSession session: NextLevelSession) {

    }

    func nextLevel(_ nextLevel: NextLevel, didCompletePhotoCaptureFromVideoFrame photoDict: [String: Any]?) {

    }
}

// MARK: - NextLevelVideoDelegate
extension SmileMeCameraViewController: NextLevelDeviceDelegate {
    func nextLevelDevicePositionWillChange(_ nextLevel: NextLevel) {
    }

    func nextLevelDevicePositionDidChange(_ nextLevel: NextLevel) {
    }

    func nextLevel(_ nextLevel: NextLevel, didChangeDeviceOrientation deviceOrientation: NextLevelDeviceOrientation) {
        DispatchQueue.main.async {
            if !self.takePhotoBtn.isEnabled {
                self.takePhotoBtn.isEnabled = true
            }
        }
    }

    func nextLevel(_ nextLevel: NextLevel, didChangeDeviceFormat deviceFormat: AVCaptureDevice.Format) {
    }

    func nextLevel(_ nextLevel: NextLevel, didChangeCleanAperture cleanAperture: CGRect) {
    }

    func nextLevel(_ nextLevel: NextLevel, didChangeLensPosition lensPosition: Float) {
    }

    func nextLevelWillStartFocus(_ nextLevel: NextLevel) {
    }

    func nextLevelDidStopFocus(_ nextLevel: NextLevel) {
    }

    func nextLevelWillChangeExposure(_ nextLevel: NextLevel) {
    }

    func nextLevelDidChangeExposure(_ nextLevel: NextLevel) {
    }

    func nextLevelWillChangeWhiteBalance(_ nextLevel: NextLevel) {
    }

    func nextLevelDidChangeWhiteBalance(_ nextLevel: NextLevel) {
    }

}


extension UIView {
    func screenshot() -> UIImage? {
        var screenshotImage: UIImage?
        let layer = self.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        self.drawHierarchy(in: layer.bounds, afterScreenUpdates: false)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}
