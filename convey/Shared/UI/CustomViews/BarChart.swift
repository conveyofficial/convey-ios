//
//  BarChart.swift
//  convey
//

import SwiftUI

public struct BarChart: View {
    public struct DataSet {
        public struct DataElement {
            
            public struct Bar {
                
                public let value: Double
                
                public let color: Color
                
                
                
                public init(value: Double, color: Color) {
                    self.value = value
                    self.color = color
                }
            }
            
            public let date: Date?
            public let xLabel: String
            public let bars: [Bar]
            
            
            public init(date: Date?, xLabel: String, bars: [BarChart.DataSet.DataElement.Bar]) {
                self.date = date
                self.xLabel = xLabel
                self.bars = bars
            }
        }
        
        public let elements: [DataElement]
        public let selectionColor: Color?
        
        public init(elements: [BarChart.DataSet.DataElement], selectionColor: Color?) {
            self.elements = elements
            self.selectionColor = selectionColor
        }
    }
    
    public let dataSet: DataSet
    @Binding public var selectedElement: DataSet.DataElement?
    public let barWidth: CGFloat
    
    private var maxDataSetValue: Double {
        dataSet.elements.flatMap { $0.bars.map { $0.value } }.max() ?? Double.leastNonzeroMagnitude
    }
    
    public var body: some View {
        HStack(alignment: .firstTextBaseline) {
            ForEach(dataSet.elements) { element in
                VStack {
                    
                    
                    HStack {
                        ForEach(element.bars) { bar in
                            VStack {
                                Rectangle()
                                    .frame(width: barWidth, height: self.height(for: bar, viewHeight: 100, maxValue: self.maxDataSetValue))
                                    .cornerRadius(barWidth / 2, antialiased: false)
                                    .foregroundColor(self.selectedElement == element ? self.dataSet.selectionColor ?? bar.color : bar.color)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .bottom)
                            
                        }
                    }
                    
                    
                    Text(element.xLabel)
                        .font(.system(size: 10))
                    
                }
            }
        }
    }
    
    public init(dataSet: BarChart.DataSet, selectedElement: Binding<DataSet.DataElement?>, barWidth: CGFloat = 6) {
        self.dataSet = dataSet
        self._selectedElement = selectedElement
        self.barWidth = barWidth
    }
    
    private func height(for bar: DataSet.DataElement.Bar, viewHeight: CGFloat, maxValue: Double) -> CGFloat {
        let height = viewHeight * CGFloat(bar.value / self.maxDataSetValue)
        
        if height < barWidth {
            return barWidth
        } else if height >= viewHeight {
            return viewHeight
        } else {
            return height
        }
    }
}

extension BarChart.DataSet.DataElement: Identifiable {
    public var id: String {
        xLabel
    }
}

extension BarChart.DataSet.DataElement: Equatable {
    public static func == (lhs: BarChart.DataSet.DataElement, rhs: BarChart.DataSet.DataElement) -> Bool {
        lhs.id == rhs.id
    }
}

extension BarChart.DataSet.DataElement.Bar: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}

extension BarChart.DataSet.DataElement.Bar: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
