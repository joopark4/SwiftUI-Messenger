//
//  SmileMeEmoticonCollectionViewCell.swift
//  ChatModuleMessengerAppApple
//

// 이모티콘 만들기 안에서 filter, sticker에 대한 collectionView

import UIKit

class SmileMeEmoticonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var styleName: UILabel!
    @IBOutlet weak var selectedView: UIView!

    private let filterNameList: [String] = ["없음", "선명하게", "흑백", "세피아", "따뜻하게", "차갑게"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setConfigFilterThumb(index: Int) {
        filterImage.image = getFilterThumbnail(index: index)
        styleName.text = filterNameList[index]
    }

    func setConfigStickerThumb(name: String, imageUrl: URL) {
        self.filterImage.image = UIImage(contentsOfFile: imageUrl.path)
        self.styleName.text = name
    }

    func setSelected(isSelect: Bool) {
        self.selectedView.isHidden = !isSelect
    }

    func getFilterThumbnail(index: Int) -> UIImage {
        var thmubName = ""

        switch index {
        case 0:
            thmubName = "Filter_Thumbnail_None"
        case 1:
            thmubName = "Filter_Thumbnail_Sharp"
        case 2:
            thmubName = "Filter_Thumbnail_Mono"
        case 3:
            thmubName = "Filter_Thumbnail_Sepia"
        case 4:
            thmubName = "Filter_Thumbnail_Warm"
        case 5:
            thmubName = "Filter_Thumbnail_Cold"
        default:
            thmubName = "Filter_Thumbnail_None"
        }

        return UIImage(named: thmubName)  ?? UIImage()
    }
}
