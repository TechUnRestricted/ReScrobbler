//
//  DefaultProfilePictureView.swift
//  ReScrobbler
//
//  Created by Mac on 19.09.2021.
//

import SwiftUI

struct DefaultProfilePictureView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.49669*width, y: 0.99338*height))
        path.addCurve(to: CGPoint(x: 0.65293*width, y: 0.96808*height), control1: CGPoint(x: 0.55132*width, y: 0.99338*height), control2: CGPoint(x: 0.6034*width, y: 0.98494*height))
        path.addCurve(to: CGPoint(x: 0.78939*width, y: 0.89717*height), control1: CGPoint(x: 0.70246*width, y: 0.95121*height), control2: CGPoint(x: 0.74795*width, y: 0.92758*height))
        path.addCurve(to: CGPoint(x: 0.89718*width, y: 0.78939*height), control1: CGPoint(x: 0.83085*width, y: 0.86677*height), control2: CGPoint(x: 0.86677*width, y: 0.83084*height))
        path.addCurve(to: CGPoint(x: 0.96808*width, y: 0.65293*height), control1: CGPoint(x: 0.92758*width, y: 0.74794*height), control2: CGPoint(x: 0.95122*width, y: 0.70245*height))
        path.addCurve(to: CGPoint(x: 0.99338*width, y: 0.49669*height), control1: CGPoint(x: 0.98494*width, y: 0.6034*height), control2: CGPoint(x: 0.99338*width, y: 0.55132*height))
        path.addCurve(to: CGPoint(x: 0.96808*width, y: 0.34045*height), control1: CGPoint(x: 0.99338*width, y: 0.44205*height), control2: CGPoint(x: 0.98494*width, y: 0.38997*height))
        path.addCurve(to: CGPoint(x: 0.897*width, y: 0.20398*height), control1: CGPoint(x: 0.95122*width, y: 0.29092*height), control2: CGPoint(x: 0.92752*width, y: 0.24543*height))
        path.addCurve(to: CGPoint(x: 0.78922*width, y: 0.09602*height), control1: CGPoint(x: 0.86648*width, y: 0.16253*height), control2: CGPoint(x: 0.83055*width, y: 0.12654*height))
        path.addCurve(to: CGPoint(x: 0.65275*width, y: 0.02512*height), control1: CGPoint(x: 0.74789*width, y: 0.0655*height), control2: CGPoint(x: 0.7024*width, y: 0.04186*height))
        path.addCurve(to: CGPoint(x: 0.49633*width, y: 0), control1: CGPoint(x: 0.6031*width, y: 0.00837*height), control2: CGPoint(x: 0.55097*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.34027*width, y: 0.02512*height), control1: CGPoint(x: 0.44194*width, y: 0), control2: CGPoint(x: 0.38992*width, y: 0.00837*height))
        path.addCurve(to: CGPoint(x: 0.20381*width, y: 0.09602*height), control1: CGPoint(x: 0.29063*width, y: 0.04186*height), control2: CGPoint(x: 0.24514*width, y: 0.0655*height))
        path.addCurve(to: CGPoint(x: 0.09602*width, y: 0.20398*height), control1: CGPoint(x: 0.16248*width, y: 0.12654*height), control2: CGPoint(x: 0.12655*width, y: 0.16253*height))
        path.addCurve(to: CGPoint(x: 0.02512*width, y: 0.34045*height), control1: CGPoint(x: 0.0655*width, y: 0.24543*height), control2: CGPoint(x: 0.04187*width, y: 0.29092*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.49669*height), control1: CGPoint(x: 0.00837*width, y: 0.38997*height), control2: CGPoint(x: 0, y: 0.44205*height))
        path.addCurve(to: CGPoint(x: 0.02512*width, y: 0.65293*height), control1: CGPoint(x: 0, y: 0.55132*height), control2: CGPoint(x: 0.00837*width, y: 0.6034*height))
        path.addCurve(to: CGPoint(x: 0.09602*width, y: 0.78939*height), control1: CGPoint(x: 0.04187*width, y: 0.70245*height), control2: CGPoint(x: 0.0655*width, y: 0.74794*height))
        path.addCurve(to: CGPoint(x: 0.20398*width, y: 0.89717*height), control1: CGPoint(x: 0.12655*width, y: 0.83084*height), control2: CGPoint(x: 0.16253*width, y: 0.86677*height))
        path.addCurve(to: CGPoint(x: 0.34045*width, y: 0.96808*height), control1: CGPoint(x: 0.24543*width, y: 0.92758*height), control2: CGPoint(x: 0.29092*width, y: 0.95121*height))
        path.addCurve(to: CGPoint(x: 0.49669*width, y: 0.99338*height), control1: CGPoint(x: 0.38998*width, y: 0.98494*height), control2: CGPoint(x: 0.44206*width, y: 0.99338*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.49669*width, y: 0.8847*height))
        path.addCurve(to: CGPoint(x: 0.39871*width, y: 0.87188*height), control1: CGPoint(x: 0.46581*width, y: 0.8847*height), control2: CGPoint(x: 0.43315*width, y: 0.88043*height))
        path.addCurve(to: CGPoint(x: 0.29983*width, y: 0.83375*height), control1: CGPoint(x: 0.36426*width, y: 0.86333*height), control2: CGPoint(x: 0.3313*width, y: 0.85062*height))
        path.addCurve(to: CGPoint(x: 0.21948*width, y: 0.7714*height), control1: CGPoint(x: 0.26836*width, y: 0.81689*height), control2: CGPoint(x: 0.24157*width, y: 0.7961*height))
        path.addCurve(to: CGPoint(x: 0.29181*width, y: 0.70228*height), control1: CGPoint(x: 0.24015*width, y: 0.74408*height), control2: CGPoint(x: 0.26426*width, y: 0.72104*height))
        path.addCurve(to: CGPoint(x: 0.38445*width, y: 0.6597*height), control1: CGPoint(x: 0.31937*width, y: 0.68351*height), control2: CGPoint(x: 0.35025*width, y: 0.66932*height))
        path.addCurve(to: CGPoint(x: 0.49669*width, y: 0.64527*height), control1: CGPoint(x: 0.41866*width, y: 0.65008*height), control2: CGPoint(x: 0.45607*width, y: 0.64527*height))
        path.addCurve(to: CGPoint(x: 0.60786*width, y: 0.65934*height), control1: CGPoint(x: 0.5366*width, y: 0.64527*height), control2: CGPoint(x: 0.57365*width, y: 0.64996*height))
        path.addCurve(to: CGPoint(x: 0.70085*width, y: 0.70156*height), control1: CGPoint(x: 0.64206*width, y: 0.66872*height), control2: CGPoint(x: 0.67306*width, y: 0.6828*height))
        path.addCurve(to: CGPoint(x: 0.77354*width, y: 0.7714*height), control1: CGPoint(x: 0.72864*width, y: 0.72033*height), control2: CGPoint(x: 0.75287*width, y: 0.74361*height))
        path.addCurve(to: CGPoint(x: 0.69355*width, y: 0.83375*height), control1: CGPoint(x: 0.75168*width, y: 0.7961*height), control2: CGPoint(x: 0.72502*width, y: 0.81689*height))
        path.addCurve(to: CGPoint(x: 0.59467*width, y: 0.87188*height), control1: CGPoint(x: 0.66207*width, y: 0.85062*height), control2: CGPoint(x: 0.62912*width, y: 0.86333*height))
        path.addCurve(to: CGPoint(x: 0.49669*width, y: 0.8847*height), control1: CGPoint(x: 0.56023*width, y: 0.88043*height), control2: CGPoint(x: 0.52757*width, y: 0.8847*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.49669*width, y: 0.56189*height))
        path.addCurve(to: CGPoint(x: 0.41118*width, y: 0.53713*height), control1: CGPoint(x: 0.46486*width, y: 0.56165*height), control2: CGPoint(x: 0.43635*width, y: 0.5534*height))
        path.addCurve(to: CGPoint(x: 0.35132*width, y: 0.47157*height), control1: CGPoint(x: 0.386*width, y: 0.52086*height), control2: CGPoint(x: 0.36604*width, y: 0.499*height))
        path.addCurve(to: CGPoint(x: 0.32923*width, y: 0.37946*height), control1: CGPoint(x: 0.33659*width, y: 0.44413*height), control2: CGPoint(x: 0.32923*width, y: 0.41343*height))
        path.addCurve(to: CGPoint(x: 0.35114*width, y: 0.29056*height), control1: CGPoint(x: 0.32899*width, y: 0.3474*height), control2: CGPoint(x: 0.33629*width, y: 0.31776*height))
        path.addCurve(to: CGPoint(x: 0.41153*width, y: 0.22518*height), control1: CGPoint(x: 0.36598*width, y: 0.26337*height), control2: CGPoint(x: 0.38612*width, y: 0.24157*height))
        path.addCurve(to: CGPoint(x: 0.49669*width, y: 0.2006*height), control1: CGPoint(x: 0.43695*width, y: 0.20879*height), control2: CGPoint(x: 0.46533*width, y: 0.2006*height))
        path.addCurve(to: CGPoint(x: 0.58131*width, y: 0.22518*height), control1: CGPoint(x: 0.52781*width, y: 0.2006*height), control2: CGPoint(x: 0.55601*width, y: 0.20879*height))
        path.addCurve(to: CGPoint(x: 0.64153*width, y: 0.29056*height), control1: CGPoint(x: 0.60661*width, y: 0.24157*height), control2: CGPoint(x: 0.62668*width, y: 0.26337*height))
        path.addCurve(to: CGPoint(x: 0.6638*width, y: 0.37946*height), control1: CGPoint(x: 0.65637*width, y: 0.31776*height), control2: CGPoint(x: 0.6638*width, y: 0.3474*height))
        path.addCurve(to: CGPoint(x: 0.64188*width, y: 0.47175*height), control1: CGPoint(x: 0.6638*width, y: 0.41343*height), control2: CGPoint(x: 0.65649*width, y: 0.44419*height))
        path.addCurve(to: CGPoint(x: 0.58202*width, y: 0.53748*height), control1: CGPoint(x: 0.62727*width, y: 0.4993*height), control2: CGPoint(x: 0.60732*width, y: 0.52121*height))
        path.addCurve(to: CGPoint(x: 0.49669*width, y: 0.56189*height), control1: CGPoint(x: 0.55673*width, y: 0.55376*height), control2: CGPoint(x: 0.52828*width, y: 0.56189*height))
        path.closeSubpath()
        return path
    }
}
