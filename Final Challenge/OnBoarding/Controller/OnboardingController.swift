import UIKit



class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var buttonGetStarted: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButtonDidTapped(_ sender: Any) {
        //Function pindah page pake present
        UserDefaults.standard.set(true, forKey: "pernahbuka")
        performSegue(withIdentifier: "showLogin", sender: nil)
    }
    
    var slides:[Slide] = [];
    
    func showbutton(button: UIButton, hidden: Bool) {
        UIButton.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.nextButton.isHidden = hidden
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.bringSubviewToFront(pageControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageAtas.image = UIImage(named: "imgOnboarding2")
        slide1.labelTitle.text = "Discover Courts in BSD"
        slide1.labelDesc.text = "Find the best court to play in your area."
        slide1.background.image = UIImage(named: "bgOnboarding2")
        slide1.labelOnboarding3atas.text = ""
        slide1.labelOnboarding3bawah.text = ""
        slide1.labelOnboarding5Atas.text = ""
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageTengah.image = UIImage(named: "BuletanTengah")
        slide2.labelOnboarding3atas.text = "Book courts"
        slide2.labelOnboarding3bawah.text = "Without the hassle."
        slide2.background.image = UIImage(named: "bgOnboarding3")
        slide2.labelDesc.text = ""
        slide2.labelTitle.text = ""
        slide2.labelOnboarding5Atas.text = ""
      
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.background.image = UIImage(named: "bgOnboarding4")
        slide3.imageAtas.image = UIImage(named: "imgOnboarding4")
        slide3.labelTitle.text = "Nearby Courts"
        slide3.labelTitle.textColor = #colorLiteral(red: 1, green: 0.6685985923, blue: 0.320751369, alpha: 1)
        slide3.labelDesc.textColor = #colorLiteral(red: 1, green: 0.6685985923, blue: 0.320751369, alpha: 1)
        
        slide3.labelDesc.text = "We need your location to show nearest courts"
        slide3.labelOnboarding3atas.text = ""
        slide3.labelOnboarding3bawah.text = ""
        slide3.labelOnboarding5Atas.text = ""
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.labelOnboarding5Atas.text = "Let’s book your first court!"
        slide4.labelDesc.text = ""
        
        slide4.labelTitle.text = ""
        slide4.background.image = UIImage(named: "bgOnboarding5")
        slide4.labelOnboarding3atas.text = ""
        slide4.labelOnboarding3bawah.text = ""
        slide4.imageOnboarding5.image = UIImage(named: "imgOnboarding5")
        slide4.labelOnboarding5Atas.textColor = #colorLiteral(red: 1, green: 0.6685985923, blue: 0.320751369, alpha: 1)
        
        return [slide1, slide2, slide3, slide4]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        if pageControl.currentPage <= 2 {
            nextButton.isHidden = true
        } else {
            showbutton(button: nextButton, hidden: false)
        }
        
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.33) {
            slides[0].imageAtas.transform = CGAffineTransform(scaleX: 1 - percentOffset.x/0.33, y: 1 - percentOffset.x/0.33)
            slides[1].imageTengah.transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
            slides[1].labelOnboarding3atas
                .transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
            slides[1].labelOnboarding3bawah
                .transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
            
        } else if(percentOffset.x > 0.33 && percentOffset.x <= 0.66) {
            
            slides[1].imageTengah.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
            slides[1].labelOnboarding3atas.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
            slides[1].labelOnboarding3bawah.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
            
            slides[2].imageAtas.transform = CGAffineTransform(scaleX:  percentOffset.x/0.66, y:  percentOffset.x/0.66)
            
        }
        else if(percentOffset.x > 0.66 && percentOffset.x <= 1) {
            slides[2].imageAtas.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.33, y: (1-percentOffset.x)/0.33)
            
            slides[3].imageOnboarding5.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
        }
    }
    
    
    
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

